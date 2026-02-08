class Robot {
public:
    int width, height, x, y, dir;
    vector<string> directions = {"East", "North", "West", "South"};
    vector<vector<int>> moves = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};
    int perimeter;

    Robot(int width, int height) {
        this->width = width;
        this->height = height;
        x = 0;
        y = 0;
        dir = 0;
        perimeter = 2 * (width + height) - 4;
    }

    void move(int num) {
        if (num == 0) return;
        num %= perimeter;
        if (num == 0) num = perimeter;
        while (num > 0) {
            int nx = x + moves[dir][0];
            int ny = y + moves[dir][1];
            if (nx < 0 || nx >= width || ny < 0 || ny >= height) {
                dir = (dir + 1) % 4;
                continue;
            }
            x = nx;
            y = ny;
            num--;
        }
    }

    vector<int> getPos() {
        return {x, y};
    }

    string getDir() {
        if (x == 0 && y == 0) return "South";
        if (x == 0 && y == height - 1) return "South";
        if (x == width - 1 && y == 0) return "East";
        if (x == width - 1 && y == height - 1) return "North";
        return directions[dir];
    }
};