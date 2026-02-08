#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> robotSim(int n, vector<vector<int>>& commands, vector<vector<int>>& obstacles) {
        map<int, set<int>> obstacleMap;
        for (auto& obstacle : obstacles) {
            int x = obstacle[0];
            int y = obstacle[1];
            obstacleMap[x].insert(y);
        }

        vector<int> direction = {0, 1};         int x = 0, y = 0;

        for (auto& command : commands) {
            if (command[0] == 1) {
                                int steps = command[1];
                for (int i = 0; i < steps; ++i) {
                    int nx = x + direction[0];
                    int ny = y + direction[1];
                    if (obstacleMap.find(nx) != obstacleMap.end() && obstacleMap[nx].find(ny) != obstacleMap[nx].end()) {
                        break;
                    }
                    x = nx;
                    y = ny;
                }
            } else if (command[0] == 2) {
                                int temp = direction[0];
                direction[0] = -direction[1];
                direction[1] = temp;
            } else if (command[0] == 3) {
                                int temp = direction[0];
                direction[0] = direction[1];
                direction[1] = -temp;
            }
        }

        return {x, y};
    }
};