public class Solution {
    public int minCount(int[] coins) {
        int count = 0;
        for (int coin : coins) {
            count += coin / 2;
            if (coin % 2 != 0) {
                count++;
            }
        }
        return count;
    }
}