class Solution {
public:
    bool robot(string command, vector<vector<int>>& obstacles, int x, int y) {
        unordered_set<long long> obs;
        for (auto& ob : obstacles) {
            if (ob[0] <= x && ob[1] <= y) {
                obs.insert((long long)ob[0] * 1000000001 + ob[1]);
            }
        }

        int cx = 0, cy = 0;
        int u = 0, r = 0;
        for (char c : command) {
            if (c == 'U') u++;
            else r++;
        }

        int k = min(x / r, y / u);
        if (k * r <= x && k * u <= y && (x - k * r) + (y - k * u) <= command.size()) {
            int total = k * command.size();
            cx = k * r;
            cy = k * u;
            for (int i = 0; i <= command.size(); ++i) {
                if (cx == x && cy == y) return true;
                if (i < command.size()) {
                    if (command[i] == 'U') cy++;
                    else cx++;
                    total++;
                }
                if (cx > x || cy > y) break;
                if (obs.count((long long)cx * 1000000001 + cy)) return false;
                if (cx == x && cy == y) return true;
            }
        }
        return false;
    }
};