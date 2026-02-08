#include <vector>
#include <queue>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int slidingPuzzle(vector<vector<int>>& board) {
        string target = "123450";
        string start = to_string(board[0][0]) + to_string(board[0][1]) + to_string(board[0][2]) +
                       to_string(board[1][0]) + to_string(board[1][1]) + to_string(board[1][2]);

        if (start == target) return 0;

        vector<vector<int>> neighbors = {{1, 3}, {0, 2, 4}, {1, 5}, {0, 4}, {1, 3, 5}, {2, 4}};
        unordered_set<string> visited;
        queue<pair<string, int>> q;
        q.push({start, 0});
        visited.insert(start);

        while (!q.empty()) {
            auto [current, steps] = q.front();
            q.pop();

            int zeroIndex = current.find('0');
            for (int neighbor : neighbors[zeroIndex]) {
                string next = current;
                swap(next[zeroIndex], next[neighbor]);
                if (next == target) return steps + 1;
                if (visited.find(next) == visited.end()) {
                    visited.insert(next);
                    q.push({next, steps + 1});
                }
            }
        }
        return -1;
    }
};