class Solution {
    public int minimizeMax(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int left = 0, right = nums[n - 1] - nums[0];
        int ans = right;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            boolean possible = true;
            long prev = nums[0];
            for (int i = 1; i < n; i++) {
                if (nums[i] > prev) {
                    long diff = nums[i] - prev;
                    if (diff > mid) {
                        possible = false;
                        break;
                    }
                }
                prev = (nums[i] + prev) / 2;
            }
            if (possible) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return ans;
    }
}