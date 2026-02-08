class Solution {
    public int maxSumRangeQuery(int[] nums, int[][] requests) {
        int n = nums.length;
        int[] count = new int[n];
        for (int[] request : requests) {
            int start = request[0];
            int end = request[1];
            count[start]++;
            if (end + 1 < n) {
                count[end + 1]--;
            }
        }
        for (int i = 1; i < n; i++) {
            count[i] += count[i - 1];
        }
        Arrays.sort(nums);
        Arrays.sort(count);
        long res = 0;
        for (int i = 0; i < n; i++) {
            res += (long) nums[i] * count[i];
        }
        return (int) (res % 1_000_000_007);
    }
}