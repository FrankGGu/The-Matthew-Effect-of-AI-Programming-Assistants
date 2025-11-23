class Solution {
    public int maxSumRangeQuery(int[] nums, int[][] requests) {
        int n = nums.length;
        int[] freq = new int[n];
        for (int[] request : requests) {
            int start = request[0];
            int end = request[1];
            freq[start]++;
            if (end + 1 < n) {
                freq[end + 1]--;
            }
        }

        for (int i = 1; i < n; i++) {
            freq[i] += freq[i - 1];
        }

        Arrays.sort(nums);
        Arrays.sort(freq);

        long maxSum = 0;
        for (int i = 0; i < n; i++) {
            maxSum = (maxSum + (long) nums[i] * freq[i]) % 1000000007;
        }

        return (int) maxSum;
    }
}