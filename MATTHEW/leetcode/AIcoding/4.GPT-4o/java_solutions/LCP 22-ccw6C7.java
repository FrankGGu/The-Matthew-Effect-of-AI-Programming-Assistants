public class Solution {
    public int[] numOfBlackAndWhite(String[] chess) {
        int black = 0, white = 0;
        for (String row : chess) {
            for (char cell : row.toCharArray()) {
                if (cell == 'B') {
                    black++;
                } else if (cell == 'W') {
                    white++;
                }
            }
        }
        return new int[]{black, white};
    }
}