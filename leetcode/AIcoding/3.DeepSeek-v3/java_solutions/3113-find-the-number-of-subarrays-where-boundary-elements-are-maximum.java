class Solution {
    public long numberOfSubarrays(int[] nums) {
        long res = 0;
        Deque<int[]> stack = new ArrayDeque<>();
        for (int num : nums) {
            while (!stack.isEmpty() && stack.peek()[0] < num) {
                stack.pop();
            }
            if (!stack.isEmpty() && stack.peek()[0] == num) {
                stack.peek()[1]++;
            } else {
                stack.push(new int[]{num, 1});
            }
            res += stack.peek()[1];
        }
        return res;
    }
}