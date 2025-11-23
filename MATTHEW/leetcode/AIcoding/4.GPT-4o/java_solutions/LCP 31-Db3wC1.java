class Solution {
    public boolean canReach(String[] maze, int[] start, String[] directions) {
        int rows = maze.length;
        int cols = maze[0].length();
        boolean[][] visited = new boolean[rows][cols];
        int x = start[0], y = start[1];

        for (String direction : directions) {
            if (direction.equals("U")) x--;
            else if (direction.equals("D")) x++;
            else if (direction.equals("L")) y--;
            else if (direction.equals("R")) y++;

            if (x < 0 || x >= rows || y < 0 || y >= cols || maze[x].charAt(y) == '#') {
                return false;
            }
            visited[x][y] = true;
        }

        return true;
    }
}