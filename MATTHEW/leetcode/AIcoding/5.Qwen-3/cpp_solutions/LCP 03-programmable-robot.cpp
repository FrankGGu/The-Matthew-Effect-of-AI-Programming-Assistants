#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>
#include <string>

using namespace std;

class Solution {
public:
    int robotSim(int n, vector<int>& commands, vector<vector<int>>& obstacles) {
        vector<vector<int>> dir = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int x = 0, y = 0;
        int maxDist = 0;
        int d = 0;

        unordered_set<string> obstacleSet;
        for (auto& obs : obstacles) {
            obstacleSet.insert(to_string(obs[0]) + "," + to_string(obs[1]));
        }

        for (int cmd : commands) {
            if (cmd == -1) {
                d = (d + 1) % 4;
            } else if (cmd == -2) {
                d = (d + 3) % 4;
            } else {
                for (int i = 0; i < cmd; ++i) {
                    int nx = x + dir[d][0];
                    int ny = y + dir[d][1];
                    string key = to_string(nx) + "," + to_string(ny);
                    if (obstacleSet.find(key) != obstacleSet.end()) {
                        break;
                    }
                    x = nx;
                    y = ny;
                    maxDist = max(maxDist, x * x + y * y);
                }
            }
        }

        return maxDist;
    }
};