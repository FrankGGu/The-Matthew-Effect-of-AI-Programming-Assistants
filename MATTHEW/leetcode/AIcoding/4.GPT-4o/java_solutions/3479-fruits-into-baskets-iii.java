public class Solution {
    public int maxFruits(int[] fruits) {
        int n = fruits.length;
        int left = 0, right = 0;
        int[] count = new int[100001];
        int maxFruits = 0;

        while (right < n) {
            count[fruits[right]]++;
            while (count[fruits[right]] > 1) {
                count[fruits[left]]--;
                left++;
            }
            maxFruits = Math.max(maxFruits, right - left + 1);
            right++;
        }

        return maxFruits;
    }
}