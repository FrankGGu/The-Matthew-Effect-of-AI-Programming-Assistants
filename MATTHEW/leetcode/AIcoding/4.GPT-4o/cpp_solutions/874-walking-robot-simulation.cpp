class Solution {
public:
    int robotSim(vector<int>& commands, vector<vector<int>>& obstacles) {
        set<pair<int, int>> obstacleSet;
        for (const auto& obstacle : obstacles) {
            obstacleSet.insert({obstacle[0], obstacle[1]});
        }

        int x = 0, y = 0, direction = 0;
        vector<int> dx = {0, 1, 0, -1};
        vector<int> dy = {1, 0, -1, 0};
        int maxDistance = 0;

        for (int command : commands) {
            if (command == -2) {
                direction = (direction + 3) % 4;
            } else if (command == -1) {
                direction = (direction + 1) % 4;
            } else {
                for (int i = 0; i < command; ++i) {
                    int nextX = x + dx[direction];
                    int nextY = y + dy[direction];
                    if (obstacleSet.count({nextX, nextY}) == 0) {
                        x = nextX;
                        y = nextY;
                        maxDistance = max(maxDistance, x * x + y * y);
                    } else {
                        break;
                    }
                }
            }
        }

        return maxDistance;
    }
};