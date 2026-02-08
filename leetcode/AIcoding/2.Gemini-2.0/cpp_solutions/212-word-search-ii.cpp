#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class TrieNode {
public:
    TrieNode* children[26];
    string word;
    TrieNode() {
        for (int i = 0; i < 26; i++) {
            children[i] = nullptr;
        }
        word = "";
    }
};

class Trie {
public:
    TrieNode* root;
    Trie() {
        root = new TrieNode();
    }

    void insert(string word) {
        TrieNode* node = root;
        for (char c : word) {
            int index = c - 'a';
            if (!node->children[index]) {
                node->children[index] = new TrieNode();
            }
            node = node->children[index];
        }
        node->word = word;
    }
};

class Solution {
public:
    vector<string> findWords(vector<vector<char>>& board, vector<string>& words) {
        Trie trie;
        for (string word : words) {
            trie.insert(word);
        }

        unordered_set<string> result_set;
        int rows = board.size();
        int cols = board[0].size();
        vector<vector<bool>> visited(rows, vector<bool>(cols, false));

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                dfs(board, i, j, trie.root, visited, result_set);
            }
        }

        vector<string> result(result_set.begin(), result_set.end());
        return result;
    }

private:
    void dfs(vector<vector<char>>& board, int row, int col, TrieNode* node, vector<vector<bool>>& visited, unordered_set<string>& result) {
        if (row < 0 || row >= board.size() || col < 0 || col >= board[0].size() || visited[row][col] || !node->children[board[row][col] - 'a']) {
            return;
        }

        visited[row][col] = true;
        TrieNode* next_node = node->children[board[row][col] - 'a'];

        if (!next_node->word.empty()) {
            result.insert(next_node->word);
        }

        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        for (int i = 0; i < 4; i++) {
            dfs(board, row + dx[i], col + dy[i], next_node, visited, result);
        }

        visited[row][col] = false;
    }
};