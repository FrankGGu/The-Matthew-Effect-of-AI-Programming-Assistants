#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int robotSim(int n, vector<int>& commands, vector<vector<int>>& obstacles) {
        vector<vector<int>> dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int x = 0, y = 0;
        int maxDistance = 0;
        int dir = 0;
        vector<set<int>> obstacleSet(2);
        for (auto& ob : obstacles) {
            obstacleSet[0].insert(ob[0]);
            obstacleSet[1].insert(ob[1]);
        }
        for (int cmd : commands) {
            if (cmd == -1) {
                dir = (dir + 1) % 4;
            } else if (cmd == -2) {
                dir = (dir + 3) % 4;
            } else {
                for (int i = 0; i < cmd; ++i) {
                    int nx = x + dirs[dir][0];
                    int ny = y + dirs[dir][1];
                    if (obstacleSet[0].find(nx) != obstacleSet[0].end() && obstacleSet[1].find(ny) != obstacleSet[1].end()) {
                        break;
                    }
                    x = nx;
                    y = ny;
                    maxDistance = max(maxDistance, x * x + y * y);
                }
            }
        }
        return maxDistance;
    }
};