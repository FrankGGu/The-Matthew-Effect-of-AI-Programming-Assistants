#include <vector>
#include <set>
#include <algorithm>

class Solution {
public:
    int robotSim(std::vector<int>& commands, std::vector<std::vector<int>>& obstacles) {
        int x = 0, y = 0;
        int dir = 0; // 0: N, 1: E, 2: S, 3: W
        int dx[] = {0, 1, 0, -1};
        int dy[] = {1, 0, -1, 0};

        std::set<std::pair<int, int>> obstacleSet;
        for (const auto& obs : obstacles) {
            obstacleSet.insert({obs[0], obs[1]});
        }

        int maxDistSq = 0;

        for (int cmd : commands) {
            if (cmd == -2) {
                dir = (dir + 3) % 4;
            } else if (cmd == -1) {
                dir = (dir + 1) % 4;
            } else {
                for (int i = 0; i < cmd; ++i) {
                    int next_x = x + dx[dir];
                    int next_y = y + dy[dir];
                    if (obstacleSet.count({next_x, next_y})) {
                        break;
                    }
                    x = next_x;
                    y = next_y;
                }
                maxDistSq = std::max(maxDistSq, x * x + y * y);
            }
        }

        return maxDistSq;
    }
};