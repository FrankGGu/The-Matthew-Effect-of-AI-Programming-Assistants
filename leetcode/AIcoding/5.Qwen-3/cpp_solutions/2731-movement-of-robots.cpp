#include <iostream>
#include <vector>
#include <string>
#include <cmath>

using namespace std;

class Solution {
public:
    int robotSim(int n, vector<int>& commands, vector<vector<int>>& obstacles) {
        vector<int> dir = {0, 1, 0, -1, 0};
        int x = 0, y = 0;
        int maxDistance = 0;
        int d = 1;
        vector<set<int>> obstacleSet(2);
        for (auto& o : obstacles) {
            obstacleSet[0].insert(o[0]);
            obstacleSet[1].insert(o[1]);
        }
        for (int i = 0; i < n; i++) {
            if (commands[i] == -1) {
                d = (d + 1) % 4;
            } else if (commands[i] == -2) {
                d = (d + 3) % 4;
            } else {
                int steps = commands[i];
                int dx = dir[d];
                int dy = dir[(d + 1) % 4];
                for (int j = 0; j < steps; j++) {
                    int nx = x + dx;
                    int ny = y + dy;
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