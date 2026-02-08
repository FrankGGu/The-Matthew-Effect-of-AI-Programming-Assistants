#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
private:
    vector<vector<char>> board;
    unordered_set<string> result;
    int m, n;

    void dfs(int i, int j, string& path, vector<vector<bool>>& visited, const vector<vector<char>>& trie) {
        if (i < 0 || i >= m || j < 0 || j >= n || visited[i][j]) return;
        path.push_back(board[i][j]);
        visited[i][j] = true;

        if (trie[i][j] == '#') {
            result.insert(path);
        } else {
            for (int dx = -1; dx <= 1; ++dx) {
                for (int dy = -1; dy <= 1; ++dy) {
                    if (abs(dx) + abs(dy) == 1) {
                        dfs(i + dx, j + dy, path, visited, trie);
                    }
                }
            }
        }

        visited[i][j] = false;
        path.pop_back();
    }

public:
    vector<string> findWords(vector<vector<char>>& board, vector<string>& words) {
        m = board.size();
        n = board[0].size();
        this->board = board;

        vector<vector<char>> trie(m, vector<char>(n, ' '));
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                trie[i][j] = board[i][j];
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                vector<vector<bool>> visited(m, vector<bool>(n, false));
                string path;
                dfs(i, j, path, visited, trie);
            }
        }

        return vector<string>(result.begin(), result.end());
    }
};