class Solution {
    public long maxSum(List<Integer> nums, int m, int k) {
        long maxSum = 0;
        long currentSum = 0;
        Map<Integer, Integer> freq = new HashMap<>();
        int left = 0;

        for (int right = 0; right < nums.size(); right++) {
            int num = nums.get(right);
            currentSum += num;
            freq.put(num, freq.getOrDefault(num, 0) + 1);

            if (right - left + 1 > k) {
                int leftNum = nums.get(left);
                currentSum -= leftNum;
                freq.put(leftNum, freq.get(leftNum) - 1);
                if (freq.get(leftNum) == 0) {
                    freq.remove(leftNum);
                }
                left++;
            }

            if (right - left + 1 == k && freq.size() >= m) {
                maxSum = Math.max(maxSum, currentSum);
            }
        }

        return maxSum;
    }
}