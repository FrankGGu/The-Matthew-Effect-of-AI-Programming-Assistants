class Robot {
    private int x, y, d;
    private int[][] bounds;

    public Robot(int width, int height) {
        x = 0;
        y = 0;
        d = 0;
        bounds = new int[][]{{0, width - 1}, {0, height - 1}};
    }

    public void move(int num) {
        for (int i = 0; i < num; i++) {
            if (d == 0) {
                if (x + 1 > bounds[0][1]) {
                    d = 1;
                    continue;
                }
                x++;
            } else if (d == 1) {
                if (y + 1 > bounds[1][1]) {
                    d = 2;
                    continue;
                }
                y++;
            } else if (d == 2) {
                if (x - 1 < bounds[0][0]) {
                    d = 3;
                    continue;
                }
                x--;
            } else {
                if (y - 1 < bounds[1][0]) {
                    d = 0;
                    continue;
                }
                y--;
            }
        }
    }

    public int[] getPos() {
        return new int[]{x, y};
    }

    public String getDir() {
        if (d == 0) return "East";
        if (d == 1) return "North";
        if (d == 2) return "West";
        return "South";
    }
}