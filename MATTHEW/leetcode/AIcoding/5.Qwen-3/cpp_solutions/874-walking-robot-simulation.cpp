#include <iostream>
#include <vector>
#include <unordered_set>
#include <cmath>

using namespace std;

class Solution {
public:
    int robotSim(vector<int>& instructions, vector<vector<int>>& obstacles) {
        vector<vector<int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int dir = 0;
        int x = 0, y = 0;
        int maxDistance = 0;
        unordered_set<string> obstacleSet;
        for (auto& obs : obstacles) {
            obstacleSet.insert(to_string(obs[0]) + "," + to_string(obs[1]));
        }
        for (char c : instructions) {
            if (c == 'L') {
                dir = (dir + 3) % 4;
            } else if (c == 'R') {
                dir = (dir + 1) % 4;
            } else {
                while (true) {
                    int nx = x + directions[dir][0];
                    int ny = y + directions[dir][1];
                    string key = to_string(nx) + "," + to_string(ny);
                    if (obstacleSet.find(key) != obstacleSet.end()) {
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