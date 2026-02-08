class Solution {
public:
    bool isRobotBounded(string instructions) {
        int x = 0, y = 0, dir = 0;
        int dx[] = {0, 1, 0, -1};
        int dy[] = {1, 0, -1, 0};

        for (char instruction : instructions) {
            if (instruction == 'G') {
                x += dx[dir];
                y += dy[dir];
            } else if (instruction == 'L') {
                dir = (dir + 3) % 4;
            } else {
                dir = (dir + 1) % 4;
            }
        }

        return (x == 0 && y == 0) || (dir != 0);
    }
};