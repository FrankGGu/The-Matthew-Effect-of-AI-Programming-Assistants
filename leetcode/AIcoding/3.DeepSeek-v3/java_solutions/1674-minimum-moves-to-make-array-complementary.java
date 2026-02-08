class Solution {
    public int minMoves(int[] nums, int limit) {
        int[] delta = new int[2 * limit + 2];
        int n = nums.length;
        for (int i = 0; i < n / 2; i++) {
            int a = nums[i], b = nums[n - 1 - i];
            int left = 2, right = 2 * limit;
            delta[left] += 2;
            delta[right + 1] -= 2;

            left = 1 + Math.min(a, b);
            right = limit + Math.max(a, b);
            delta[left] += -1;
            delta[right + 1] -= -1;

            left = a + b;
            right = a + b;
            delta[left] += -1;
            delta[right + 1] -= -1;
        }

        int res = Integer.MAX_VALUE;
        int current = 0;
        for (int i = 2; i <= 2 * limit; i++) {
            current += delta[i];
            if (current < res) {
                res = current;
            }
        }
        return res;
    }
}