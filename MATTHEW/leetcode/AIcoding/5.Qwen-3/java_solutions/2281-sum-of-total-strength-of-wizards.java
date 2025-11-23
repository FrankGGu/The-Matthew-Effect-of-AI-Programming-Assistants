public class Solution {

import java.util.*;

public class Solution {
    public int totalStrength(int[] strength) {
        int MOD = 1000000007;
        int n = strength.length;
        int[] left = new int[n];
        int[] right = new int[n];
        Stack<Integer> stack = new Stack<>();

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

        long[] prefix = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = (prefix[i] + strength[i]) % MOD;
        }

        long[] prefix2 = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefix2[i + 1] = (prefix2[i] + prefix[i + 1]) % MOD;
        }

        long result = 0;
        for (int i = 0; i < n; i++) {
            int l = left[i];
            int r = right[i];
            int lenL = i - l;
            int lenR = r - i;
            long sumL = (prefix[i + 1] - prefix[l + 1]) % MOD;
            long sumR = (prefix[r] - prefix[i]) % MOD;
            long total = (sumL * (lenR) % MOD) * (lenL) % MOD;
            total = (total * (sumR) % MOD) * (lenL) % MOD;
            result = (result + total) % MOD;
        }

        return (int) result;
    }
}
}