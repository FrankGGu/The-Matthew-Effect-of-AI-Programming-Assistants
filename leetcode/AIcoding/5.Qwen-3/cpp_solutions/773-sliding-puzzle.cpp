#include <vector>
#include <queue>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int slidingPuzzle(vector<vector<int>>& board) {
        string start;
        for (int i = 0; i < 3; ++i) {
            for (int j = 0; j < 2; ++j) {
                start += to_string(board[i][j]);
            }
        }

        string target = "123450";

        vector<vector<int>> neighbors = {
            {1, 3},
            {0, 2, 4},
            {1, 5},
            {0, 4},
            {1, 3, 5},
            {2, 4}
        };

        queue<pair<string, int>> q;
        q.push({start, 0});
        unordered_set<string> visited;
        visited.insert(start);

        while (!q.empty()) {
            auto [current, steps] = q.front();
            q.pop();

            if (current == target) {
                return steps;
            }

            int idx = current.find('0');
            for (int neighbor : neighbors[idx]) {
                string next = current;
                swap(next[idx], next[neighbor]);
                if (visited.find(next) == visited.end()) {
                    visited.insert(next);
                    q.push({next, steps + 1});
                }
            }
        }

        return -1;
    }
};