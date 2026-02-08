class Solution {
    public int totalSteps(int[] nums) {
        int n = nums.length;
        int res = 0;
        Stack<int[]> stack = new Stack<>();
        for (int i = n - 1; i >= 0; i--) {
            int cnt = 0;
            while (!stack.isEmpty() && stack.peek()[0] < nums[i]) {
                cnt = Math.max(cnt + 1, stack.pop()[1]);
            }
            res = Math.max(res, cnt);
            stack.push(new int[]{nums[i], cnt});
        }
        return res;
    }
}