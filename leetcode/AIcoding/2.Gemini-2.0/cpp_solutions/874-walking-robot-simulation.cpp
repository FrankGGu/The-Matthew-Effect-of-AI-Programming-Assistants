#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int robotSim(vector<int>& commands, vector<vector<int>>& obstacles) {
        int x = 0, y = 0, dir = 0;
        int dx[] = {0, 1, 0, -1};
        int dy[] = {1, 0, -1, 0};
        unordered_set<long long> obs;
        for (auto& obstacle : obstacles) {
            obs.insert(((long long)obstacle[0] + 30000) * 60001 + (obstacle[1] + 30000));
        }

        int maxDistSq = 0;
        for (int command : commands) {
            if (command == -2) {
                dir = (dir + 3) % 4;
            } else if (command == -1) {
                dir = (dir + 1) % 4;
            } else {
                for (int i = 0; i < command; ++i) {
                    int nx = x + dx[dir];
                    int ny = y + dy[dir];
                    if (obs.count(((long long)nx + 30000) * 60001 + (ny + 30000))) {
                        break;
                    }
                    x = nx;
                    y = ny;
                    maxDistSq = max(maxDistSq, x * x + y * y);
                }
            }
        }

        return maxDistSq;
    }
};