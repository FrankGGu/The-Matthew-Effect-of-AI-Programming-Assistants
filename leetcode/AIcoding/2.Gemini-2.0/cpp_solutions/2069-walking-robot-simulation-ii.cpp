class Robot {
public:
    int width, height;
    int x, y;
    string dir;

    Robot(int width, int height) {
        this->width = width;
        this->height = height;
        x = 0;
        y = 0;
        dir = "East";
    }

    void step(int num) {
        int perimeter = 2 * (width + height - 2);
        num %= perimeter;

        while (num > 0) {
            if (dir == "East") {
                if (x + num < width) {
                    x += num;
                    num = 0;
                } else {
                    num -= (width - 1 - x);
                    x = width - 1;
                    dir = "North";
                }
            } else if (dir == "North") {
                if (y + num < height) {
                    y += num;
                    num = 0;
                } else {
                    num -= (height - 1 - y);
                    y = height - 1;
                    dir = "West";
                }
            } else if (dir == "West") {
                if (x - num >= 0) {
                    x -= num;
                    num = 0;
                } else {
                    num -= x;
                    x = 0;
                    dir = "South";
                }
            } else {
                if (y - num >= 0) {
                    y -= num;
                    num = 0;
                } else {
                    num -= y;
                    y = 0;
                    dir = "East";
                }
            }
        }
    }

    vector<int> getPos() {
        return {x, y};
    }

    string getDir() {
        return dir;
    }
};