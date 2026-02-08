class Solution {
    public int maximumSum(int[] nums) {
        Map<Integer, Integer> map = new HashMap<>();
        int maxSum = -1;
        for (int num : nums) {
            int sumDigits = sumOfDigits(num);
            if (map.containsKey(sumDigits)) {
                int currentSum = num + map.get(sumDigits);
                if (currentSum > maxSum) {
                    maxSum = currentSum;
                }
                if (num > map.get(sumDigits)) {
                    map.put(sumDigits, num);
                }
            } else {
                map.put(sumDigits, num);
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