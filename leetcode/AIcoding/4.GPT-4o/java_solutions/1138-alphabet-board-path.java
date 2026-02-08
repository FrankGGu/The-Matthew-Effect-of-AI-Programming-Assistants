class Solution {
    public String alphabetBoardPath(String target) {
        StringBuilder path = new StringBuilder();
        int x = 0, y = 0;

        for (char c : target.toCharArray()) {
            int targetX = (c - 'a') / 5;
            int targetY = (c - 'a') % 5;

            while (x > targetX) {
                path.append('U');
                x--;
            }
            while (y > targetY) {
                path.append('L');
                y--;
            }
            while (x < targetX) {
                path.append('D');
                x++;
            }
            while (y < targetY) {
                path.append('R');
                y++;
            }
            path.append('!');
        }

        return path.toString();
    }
}