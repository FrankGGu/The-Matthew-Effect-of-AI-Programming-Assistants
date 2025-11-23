class Solution {
    public long countGood(int[] nums, int k) {
        int n = nums.length;
        long count = 0;
        int left = 0;
        long currentPairs = 0;
        java.util.Map<Integer, Integer> freq = new java.util.HashMap<>();

        for (int right = 0; right < n; right++) {
            int num = nums[right];
            int currentFreq = freq.getOrDefault(num, 0);
            currentPairs += currentFreq;
            freq.put(num, currentFreq + 1);

            while (currentPairs >= k) {
                count += (n - right);
                int leftNum = nums[left];
                int leftFreq = freq.get(leftNum);
                currentPairs -= (leftFreq - 1);
                freq.put(leftNum, leftFreq - 1);
                left++;
            }
        }

        return count;
    }
}