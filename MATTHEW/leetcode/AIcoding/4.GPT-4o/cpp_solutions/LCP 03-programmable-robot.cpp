class Robot {
public:
    Robot(int width, int height) : w(width), h(height), x(0), y(0), dir(0) {
        grid.resize(height, vector<int>(width, 0));
    }

    void move(int num) {
        for (int i = 0; i < num; ++i) {
            if (dir == 0 && y < h - 1) y++;
            else if (dir == 1 && x < w - 1) x++;
            else if (dir == 2 && y > 0) y--;
            else if (dir == 3 && x > 0) x--;
            else return;
        }
    }

    void turnLeft() {
        dir = (dir + 3) % 4;
    }

    void turnRight() {
        dir = (dir + 1) % 4;
    }

    void paint(int color) {
        grid[y][x] = color;
    }

    int getColor() {
        return grid[y][x];
    }

private:
    int w, h, x, y, dir;
    vector<vector<int>> grid;
};