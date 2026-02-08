class TrieNode {
public:
    unordered_map<char, TrieNode*> children;
    bool isEndOfWord = false;
};

class Trie {
public:
    TrieNode* root;

    Trie() {
        root = new TrieNode();
    }

    void insert(const string& word) {
        TrieNode* node = root;
        for (char c : word) {
            if (!node->children.count(c)) {
                node->children[c] = new TrieNode();
            }
            node = node->children[c];
        }
        node->isEndOfWord = true;
    }
};

class Solution {
public:
    vector<string> findWords(vector<vector<char>>& board, vector<string>& words) {
        Trie trie;
        for (const string& word : words) {
            trie.insert(word);
        }

        set<string> result;
        int rows = board.size(), cols = board[0].size();
        vector<vector<bool>> visited(rows, vector<bool>(cols, false));

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                backtrack(board, visited, trie.root, "", i, j, result);
            }
        }

        return vector<string>(result.begin(), result.end());
    }

private:
    void backtrack(vector<vector<char>>& board, vector<vector<bool>>& visited, TrieNode* node, string currentWord, int i, int j, set<string>& result) {
        if (node->isEndOfWord) {
            result.insert(currentWord);
        }

        if (i < 0 || i >= board.size() || j < 0 || j >= board[0].size() || visited[i][j] || !node->children.count(board[i][j])) {
            return;
        }

        visited[i][j] = true;
        currentWord += board[i][j];
        TrieNode* nextNode = node->children[board[i][j]];

        backtrack(board, visited, nextNode, currentWord, i + 1, j, result);
        backtrack(board, visited, nextNode, currentWord, i - 1, j, result);
        backtrack(board, visited, nextNode, currentWord, i, j + 1, result);
        backtrack(board, visited, nextNode, currentWord, i, j - 1, result);

        visited[i][j] = false;
    }
};