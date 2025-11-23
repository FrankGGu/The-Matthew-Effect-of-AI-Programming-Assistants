#include <vector>
#include <string>
#include <array>

struct TrieNode {
    std::array<TrieNode*, 26> children;
    std::string* word; // Pointer to the actual word if this node marks the end of a word

    TrieNode() : word(nullptr) {
        children.fill(nullptr);
    }

    // Destructor to clean up children and word pointer
    ~TrieNode() {
        for (int i = 0; i < 26; ++i) {
            delete children[i]; // Recursively delete children
        }
        delete word; // Delete the string if it exists
    }
};

class Solution {
public:
    // Helper function to insert a word into the Trie
    void insert(TrieNode* root, const std::string& s) {
        TrieNode* curr = root;
        for (char c : s) {
            int idx = c - 'a';
            if (!curr->children[idx]) {
                curr->children[idx] = new TrieNode();
            }
            curr = curr->children[idx];
        }
        curr->word = new std::string(s); // Store a copy of the word
    }

    // DFS (backtracking) function to search for words
    void dfs(std::vector<std::vector<char>>& board, int r, int c, TrieNode* parent_node, std::vector<std::string>& result) {
        // Get the character at the current cell
        char char_at_rc = board[r][c];
        int idx = char_at_rc - 'a';

        // Get the Trie node corresponding to this character from the parent_node's children
        TrieNode* current_node = parent_node->children[idx];

        // If this path does not exist in the Trie, or has been pruned
        if (!current_node) {
            return;
        }

        // If this node marks the end of a word
        if (current_node->word) {
            result.push_back(*(current_node->word));
            // Mark as found to avoid duplicates and re-finding
            delete current_node->word; // Free the string memory
            current_node->word = nullptr; // Set to nullptr to indicate it's found
        }

        // Mark current cell as visited by changing its character
        board[r][c] = '#';

        int rows = board.size();
        int cols = board[0].size();

        // Explore 4 neighbors (up, down, left, right)
        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        for (int i = 0; i < 4; ++i) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            // Check bounds and if the neighbor cell is not visited
            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && board[nr][nc] != '#') {
                dfs(board, nr, nc, current_node, result); // Pass current_node as parent for the next step
            }
        }

        // Backtrack: restore the character in the board
        board[r][c] = char_at_rc;

        // Pruning optimization: If current_node has no children and no word,
        // it means no further words can be formed from this prefix, and this node itself
        // doesn't mark a word anymore. It can be safely removed.
        bool has_children = false;
        for (int i = 0; i < 26; ++i) {
            if (current_node->children[i]) {
                has_children = true;
                break;
            }
        }
        if (!has_children && !current_node->word) {
            // Remove this node from its parent and delete it
            parent_node->children[idx] = nullptr; // Disconnect from parent
            delete current_node; // Free memory of the current_node
        }
    }

    // Main function to find words
    std::vector<std::string> findWords(std::vector<std::vector<char>>& board, std::vector<std::string>& words) {
        // Handle empty board case
        if (board.empty() || board[0].empty()) {
            return {};
        }

        // Build the Trie from the list of words
        TrieNode* root = new TrieNode();
        for (const std::string& word : words) {
            insert(root, word);
        }

        std::vector<std::string> result;
        int rows = board.size();
        int cols = board[0].size();

        // Iterate through each cell of the board to start DFS
        for (int r = 0; r < rows; ++r) {
            for (int c = 0; c < cols; ++c) {
                // Start DFS from this cell, using the root of the Trie as the parent
                dfs(board, r, c, root, result);
            }
        }

        delete root; // Clean up the entire Trie memory
        return result;
    }
};