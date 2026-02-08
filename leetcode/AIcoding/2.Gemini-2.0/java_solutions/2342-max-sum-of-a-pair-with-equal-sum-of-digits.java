import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maximumSum(int[] nums) {
        Map<Integer, Integer> digitSumMap = new HashMap<>();
        int maxSum = -1;

        for (int num : nums) {
            int sumOfDigits = sumOfDigits(num);
            if (digitSumMap.containsKey(sumOfDigits)) {
                maxSum = Math.max(maxSum, digitSumMap.get(sumOfDigits) + num);
                digitSumMap.put(sumOfDigits, Math.max(digitSumMap.get(sumOfDigits), num));
            } else {
                digitSumMap.put(sumOfDigits, num);
            }
        }

        return maxSum;
    }

    private int sumOfDigits(int num) {
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum;
    }
}