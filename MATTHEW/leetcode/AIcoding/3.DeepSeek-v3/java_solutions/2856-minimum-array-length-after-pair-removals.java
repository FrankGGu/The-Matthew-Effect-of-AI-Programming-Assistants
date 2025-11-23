class Solution {
    public int minLengthAfterRemovals(List<Integer> nums) {
        int n = nums.size();
        int left = 0, right = (n + 1) / 2;
        int count = 0;
        while (right < n) {
            if (nums.get(left) < nums.get(right)) {
                count++;
                left++;
            }
            right++;
        }
        return n - 2 * count;
    }
}