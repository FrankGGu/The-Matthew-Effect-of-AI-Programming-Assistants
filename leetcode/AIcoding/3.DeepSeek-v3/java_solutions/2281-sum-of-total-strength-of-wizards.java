class Solution {
    private static final int MOD = 1_000_000_007;

    public int totalStrength(int[] strength) {
        int n = strength.length;
        long[] prefix = new long[n + 1];
        long[] prefixPrefix = new long[n + 2];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = (prefix[i] + strength[i]) % MOD;
        }
        for (int i = 0; i <= n; i++) {
            prefixPrefix[i + 1] = (prefixPrefix[i] + prefix[i]) % MOD;
        }

        int[] left = new int[n];
        int[] right = new int[n];
        Deque<Integer> stack = new ArrayDeque<>();
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && strength[stack.peek()] >= strength[i]) {
                stack.pop();
            }
            left[i] = stack.isEmpty() ? -1 : stack.peek();
            stack.push(i);
        }
        stack.clear();
        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && strength[stack.peek()] > strength[i]) {
                stack.pop();
            }
            right[i] = stack.isEmpty() ? n : stack.peek();
            stack.push(i);
        }

        long res = 0;
        for (int i = 0; i < n; i++) {
            int l = left[i] + 1;
            int r = right[i] - 1;
            long total = (prefixPrefix[r + 2] - prefixPrefix[i + 1]) * (i - l + 1) % MOD;
            total -= (prefixPrefix[i + 1] - prefixPrefix[l]) * (r - i + 1) % MOD;
            total = (total % MOD + MOD) % MOD;
            res = (res + total * strength[i]) % MOD;
        }
        return (int) res;
    }
}