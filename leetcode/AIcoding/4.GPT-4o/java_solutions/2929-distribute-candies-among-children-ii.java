public class Solution {
    public int[] distributeCandies(int candies, int numChildren) {
        int[] result = new int[numChildren];
        int round = 0;
        while (candies > 0) {
            round++;
            for (int i = 0; i < numChildren; i++) {
                if (candies <= 0) break;
                int give = Math.min(round, candies);
                result[i] += give;
                candies -= give;
            }
        }
        return result;
    }
}