class Solution {
    public int[] constructMinimumBitwiseArray(int[] nums) {
        int n = nums.length;
        int[] res = new int[n];
        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && nums[stack.peek()] > nums[i]) {
                int idx = stack.pop();
                res[idx] = nums[i];
            }
            stack.push(i);
        }

        while (!stack.isEmpty()) {
            int idx = stack.pop();
            res[idx] = -1;
        }

        return res;
    }
}