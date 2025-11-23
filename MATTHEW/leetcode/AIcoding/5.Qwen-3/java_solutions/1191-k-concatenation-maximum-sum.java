public class Solution {
    public int kConcatenationMaxSum(int[] arr) {
        int maxEndingHere = 0, maxSoFar = 0;
        for (int num : arr) {
            maxEndingHere = Math.max(num, maxEndingHere + num);
            maxSoFar = Math.max(maxSoFar, maxEndingHere);
        }
        if (maxSoFar <= 0) return maxSoFar;
        int totalSum = 0;
        for (int num : arr) totalSum += num;
        maxEndingHere = 0;
        for (int i = 0; i < 2; i++) {
            for (int num : arr) {
                maxEndingHere = Math.max(num, maxEndingHere + num);
                maxSoFar = Math.max(maxSoFar, maxEndingHere);
            }
        }
        return maxSoFar;
    }
}