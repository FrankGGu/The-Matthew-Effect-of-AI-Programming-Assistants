public class Solution {
    public int maxFruits(int[] fruits, int k) {
        int n = fruits.length;
        int maxFruits = 0;
        for (int i = 0; i < n; i++) {
            int sum = 0;
            int count = 0;
            for (int j = i; j < n; j++) {
                sum += fruits[j];
                count++;
                if (sum > k) {
                    break;
                }
                maxFruits = Math.max(maxFruits, count);
            }
        }
        return maxFruits;
    }
}