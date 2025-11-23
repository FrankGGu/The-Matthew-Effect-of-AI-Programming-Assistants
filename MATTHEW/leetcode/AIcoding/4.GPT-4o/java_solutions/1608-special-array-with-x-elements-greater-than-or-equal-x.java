class Solution {
    public int specialArray(int[] nums) {
        int left = 0, right = nums.length;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            int count = 0;
            for (int num : nums) {
                if (num >= mid) count++;
            }
            if (count == mid) return mid;
            if (count < mid) right = mid - 1;
            else left = mid + 1;
        }
        return -1;
    }
}