public class Solution {
    public int countPoints(String rings) {
        int[] black = new int[10];
        int[] white = new int[10];
        for (int i = 0; i < rings.length(); i += 2) {
            char color = rings.charAt(i);
            int rod = rings.charAt(i + 1) - '0';
            if (color == 'B') {
                black[rod]++;
            } else {
                white[rod]++;
            }
        }
        int count = 0;
        for (int i = 0; i < 10; i++) {
            if (black[i] > 0 && white[i] > 0) {
                count++;
            }
        }
        return count;
    }
}