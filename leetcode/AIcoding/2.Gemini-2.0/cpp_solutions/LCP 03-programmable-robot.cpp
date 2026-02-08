#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool programmableRobot(int m, int n, vector<int>& start, vector<vector<int>>& obstacles, string& instruction) {
        int x = start[0], y = start[1];
        for (char c : instruction) {
            int dx = 0, dy = 0;
            if (c == 'U') dx = -1;
            else if (c == 'D') dx = 1;
            else if (c == 'L') dy = -1;
            else dy = 1;

            int nx = x + dx, ny = y + dy;
            bool obstacle = false;
            for (auto& obs : obstacles) {
                if (obs[0] == nx && obs[1] == ny) {
                    obstacle = true;
                    break;
                }
            }

            if (!obstacle && nx >= 0 && nx < m && ny >= 0 && ny < n) {
                x = nx;
                y = ny;
            }
        }

        return true;
    }
};