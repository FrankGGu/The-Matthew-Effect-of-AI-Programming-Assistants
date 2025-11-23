class Robot {
    private int width;
    private int height;
    private int x;
    private int y;
    private String dir;
    private int perimeter;

    public Robot(int width, int height) {
        this.width = width;
        this.height = height;
        this.x = 0;
        this.y = 0;
        this.dir = "East";
        this.perimeter = 2 * (width + height) - 4;
    }

    public void step(int num) {
        if (num == 0) return;
        num %= perimeter;
        if (num == 0) num = perimeter;

        while (num > 0) {
            if (dir.equals("East")) {
                int steps = Math.min(num, width - 1 - x);
                x += steps;
                num -= steps;
                if (num > 0) dir = "North";
            } else if (dir.equals("North")) {
                int steps = Math.min(num, height - 1 - y);
                y += steps;
                num -= steps;
                if (num > 0) dir = "West";
            } else if (dir.equals("West")) {
                int steps = Math.min(num, x);
                x -= steps;
                num -= steps;
                if (num > 0) dir = "South";
            } else if (dir.equals("South")) {
                int steps = Math.min(num, y);
                y -= steps;
                num -= steps;
                if (num > 0) dir = "East";
            }
        }
    }

    public int[] getPos() {
        return new int[]{x, y};
    }

    public String getDir() {
        return dir;
    }
}