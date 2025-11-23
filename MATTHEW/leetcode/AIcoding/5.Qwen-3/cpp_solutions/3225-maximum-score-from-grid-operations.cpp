#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int maximumScore(int n, vector<vector<int>>& ops) {
        vector<vector<int>> grid(n, vector<int>(n, 0));
        for (auto& op : ops) {
            int x = op[0], y = op[1], val = op[2];
            grid[x][y] += val;
        }

        priority_queue<int> pq;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                pq.push(grid[i][j]);
            }
        }

        int score = 0;
        for (int i = 0; i < n * n; ++i) {
            if (pq.empty()) break;
            score += pq.top();
            pq.pop();
        }

        return score;
    }
};