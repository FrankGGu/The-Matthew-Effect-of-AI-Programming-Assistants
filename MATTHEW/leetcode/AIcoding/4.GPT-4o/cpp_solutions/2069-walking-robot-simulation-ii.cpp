class Robot {
public:
    int x, y, direction;
    vector<vector<int>> obstacles;

    Robot(int width, int height, vector<vector<int>>& obstacles) {
        x = 0;
        y = 0;
        direction = 0;
        this->obstacles = vector<vector<int>>(width + 1, vector<int>(height + 1, 0));
        for (auto& obs : obstacles) {
            this->obstacles[obs[0]][obs[1]] = 1;
        }
    }

    void move(int num) {
        while (num--) {
            int nx = x, ny = y;
            if (direction == 0) ny++;
            else if (direction == 1) nx++;
            else if (direction == 2) ny--;
            else if (direction == 3) nx--;

            if (nx < 0 || ny < 0 || nx >= obstacles.size() || ny >= obstacles[0].size() || obstacles[nx][ny]) break;

            x = nx;
            y = ny;
        }
    }

    void turnLeft() {
        direction = (direction + 3) % 4;
    }

    void turnRight() {
        direction = (direction + 1) % 4;
    }

    vector<int> getPos() {
        return {x, y};
    }

    int getDir() {
        return direction;
    }
};