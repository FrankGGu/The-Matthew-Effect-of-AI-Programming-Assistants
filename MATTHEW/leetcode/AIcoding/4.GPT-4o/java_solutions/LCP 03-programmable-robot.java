class Robot {
    private int x, y;
    private boolean[][] visited;
    private int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public Robot(int width, int height) {
        this.visited = new boolean[height][width];
        this.x = 0;
        this.y = 0;
        this.visited[0][0] = true;
    }

    public void move(int num) {
        for (int i = 0; i < num; i++) {
            int newX = x + directions[0][0];
            int newY = y + directions[0][1];
            if (newX >= 0 && newY >= 0 && newX < visited.length && newY < visited[0].length && !visited[newX][newY]) {
                x = newX;
                y = newY;
                visited[x][y] = true;
            } else {
                break;
            }
        }
    }

    public void turnLeft() {
        directions = new int[][]{{directions[3][0], directions[3][1]}, {directions[0][0], directions[0][1]}, 
                                  {directions[1][0], directions[1][1]}, {directions[2][0], directions[2][1]}};
    }

    public void turnRight() {
        directions = new int[][]{{directions[1][0], directions[1][1]}, {directions[2][0], directions[2][1]}, 
                                  {directions[3][0], directions[3][1]}, {directions[0][0], directions[0][1]}};
    }

    public boolean hasVisited(int x, int y) {
        return visited[x][y];
    }
}