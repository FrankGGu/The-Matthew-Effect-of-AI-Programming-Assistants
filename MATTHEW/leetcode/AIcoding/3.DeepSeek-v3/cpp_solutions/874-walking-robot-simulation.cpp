class Solution {
public:
    int robotSim(vector<int>& commands, vector<vector<int>>& obstacles) {
        unordered_set<string> obs;
        for (auto& o : obstacles) {
            obs.insert(to_string(o[0]) + "," + to_string(o[1]));
        }

        int dirs[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int x = 0, y = 0, dir = 0;
        int res = 0;

        for (int cmd : commands) {
            if (cmd == -2) {
                dir = (dir + 3) % 4;
            } else if (cmd == -1) {
                dir = (dir + 1) % 4;
            } else {
                for (int i = 0; i < cmd; ++i) {
                    int nx = x + dirs[dir][0];
                    int ny = y + dirs[dir][1];
                    string key = to_string(nx) + "," + to_string(ny);
                    if (obs.find(key) != obs.end()) {
                        break;
                    }
                    x = nx;
                    y = ny;
                    res = max(res, x * x + y * y);
                }
            }
        }

        return res;
    }
};