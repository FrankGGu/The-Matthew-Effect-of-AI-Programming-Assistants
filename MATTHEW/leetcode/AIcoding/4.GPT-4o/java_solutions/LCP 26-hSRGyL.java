class Solution {
    public int[] navigate(int[] commands) {
        int x = 0, y = 0;
        for (int command : commands) {
            switch (command) {
                case 0: // move up
                    y++;
                    break;
                case 1: // move right
                    x++;
                    break;
                case 2: // move down
                    y--;
                    break;
                case 3: // move left
                    x--;
                    break;
            }
        }
        return new int[]{x, y};
    }
}