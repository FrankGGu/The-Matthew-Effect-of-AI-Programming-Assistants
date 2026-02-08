class Solution {
    public String alphabetBoardPath(String target) {
        StringBuilder sb = new StringBuilder();
        int x = 0, y = 0;
        for (char c : target.toCharArray()) {
            int tx = (c - 'a') / 5;
            int ty = (c - 'a') % 5;
            while (x > tx) {
                sb.append("U");
                x--;
            }
            while (y > ty) {
                sb.append("L");
                y--;
            }
            while (x < tx) {
                sb.append("D");
                x++;
            }
            while (y < ty) {
                sb.append("R");
                y++;
            }
            sb.append("!");
        }
        return sb.toString();
    }
}