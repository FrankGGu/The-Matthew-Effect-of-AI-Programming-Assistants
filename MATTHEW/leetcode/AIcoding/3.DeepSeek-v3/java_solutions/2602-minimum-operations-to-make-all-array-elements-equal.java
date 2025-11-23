class Solution {
    public List<Long> minOperations(int[] nums, int[] queries) {
        Arrays.sort(nums);
        int n = nums.length;
        long[] prefix = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        List<Long> res = new ArrayList<>();
        for (int q : queries) {
            int idx = binarySearch(nums, q);
            long sum = (long) q * idx - prefix[idx];
            sum += (prefix[n] - prefix[idx]) - (long) q * (n - idx);
            res.add(sum);
        }
        return res;
    }

    private int binarySearch(int[] nums, int target) {
        int left = 0, right = nums.length;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}