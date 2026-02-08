class Robot {
    int width, height, x, y, dir;
    String[] directions = {"East", "North", "West", "South"};

    public Robot(int width, int height) {
        this.width = width;
        this.height = height;
        this.x = 0;
        this.y = 0;
        this.dir = 0; // East
    }

    public void step(int num) {
        num %= (2 * (width + height) - 4);
        while (num > 0) {
            if (dir == 0) { // East
                int move = Math.min(num, width - 1 - x);
                x += move;
                num -= move;
                if (x == width - 1 && num > 0) {
                    dir = 1;
                }
            } else if (dir == 1) { // North
                int move = Math.min(num, height - 1 - y);
                y += move;
                num -= move;
                if (y == height - 1 && num > 0) {
                    dir = 2;
                }
            } else if (dir == 2) { // West
                int move = Math.min(num, x);
                x -= move;
                num -= move;
                if (x == 0 && num > 0) {
                    dir = 3;
                }
            } else { // South
                int move = Math.min(num, y);
                y -= move;
                num -= move;
                if (y == 0 && num > 0) {
                    dir = 0;
                }
            }
        }
    }

    public int[] getPos() {
        return new int[]{x, y};
    }

    public String getDir() {
        return directions[dir];
    }
}