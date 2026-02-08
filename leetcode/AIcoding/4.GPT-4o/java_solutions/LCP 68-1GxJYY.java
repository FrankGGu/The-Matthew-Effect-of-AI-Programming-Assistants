import java.util.Arrays;

class Solution {
    public int beautifulBouquet(int[] flowers, int limit) {
        Arrays.sort(flowers);
        int n = flowers.length;
        int maxLength = 0;
        int currentSum = 0;

        for (int i = 0; i < n; i++) {
            currentSum += flowers[i];
            while (currentSum > limit) {
                currentSum -= flowers[i - maxLength];
                maxLength--;
            }
            maxLength++;
        }

        return maxLength;
    }
}