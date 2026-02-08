public class Solution {
    public int numberOfAlternatingGroups(int[] colors, int k) {
        int n = colors.length;
        int count = 0;
        for (int i = 0; i < n; i++) {
            boolean isAlternating = true;
            for (int j = 1; j < k; j++) {
                if (colors[(i + j) % n] == colors[(i + j - 1) % n]) {
                    isAlternating = false;
                    break;
                }
            }
            if (isAlternating) {
                count++;
            }
        }
        return count;
    }
}