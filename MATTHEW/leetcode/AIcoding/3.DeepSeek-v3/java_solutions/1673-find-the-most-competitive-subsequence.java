class Solution {
    public int[] mostCompetitive(int[] nums, int k) {
        int[] stack = new int[k];
        int top = -1;
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            while (top >= 0 && nums[i] < stack[top] && (top + n - i) >= k) {
                top--;
            }
            if (top < k - 1) {
                stack[++top] = nums[i];
            }
        }
        return stack;
    }
}