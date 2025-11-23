public class Solution {
    public boolean winnerOfGame(String colors) {
        int count = 0;
        for (int i = 1; i < colors.length() - 1; i++) {
            if (colors.charAt(i) == colors.charAt(i - 1) && colors.charAt(i) == colors.charAt(i + 1)) {
                count++;
            }
        }
        return count > 0;
    }
}