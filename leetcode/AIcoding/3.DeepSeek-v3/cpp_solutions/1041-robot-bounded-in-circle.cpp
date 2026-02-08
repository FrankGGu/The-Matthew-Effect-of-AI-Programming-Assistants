class Solution {
public:
    bool isRobotBounded(string instructions) {
        int x = 0, y = 0, dir = 0;
        vector<vector<int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        for (char c : instructions) {
            if (c == 'G') {
                x += directions[dir][0];
                y += directions[dir][1];
            } else if (c == 'L') {
                dir = (dir + 3) % 4;
            } else if (c == 'R') {
                dir = (dir + 1) % 4;
            }
        }

        return (x == 0 && y == 0) || (dir != 0);
    }
};