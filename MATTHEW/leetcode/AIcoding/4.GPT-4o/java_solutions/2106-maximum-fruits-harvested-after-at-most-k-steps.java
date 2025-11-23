import java.util.Arrays;

public class Solution {
    public int maxFruits(int[] fruits, int k) {
        int n = fruits.length;
        int maxFruits = 0;
        int left = 0;
        int right = 0;
        int currentFruits = 0;

        while (right < n) {
            currentFruits += fruits[right];
            while (right - left + 1 > k) {
                currentFruits -= fruits[left];
                left++;
            }
            maxFruits = Math.max(maxFruits, currentFruits);
            right++;
        }
        return maxFruits;
    }
}