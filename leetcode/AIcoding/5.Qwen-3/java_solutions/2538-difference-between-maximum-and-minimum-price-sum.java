public class Solution {

import java.util.*;

public class Solution {
    public int[] totalStrength(int[] A) {
        int n = A.length;
        int[] leftMin = new int[n];
        int[] rightMin = new int[n];
        int[] leftMax = new int[n];
        int[] rightMax = new int[n];
        Arrays.fill(leftMin, -1);
        Arrays.fill(rightMin, n);
        Arrays.fill(leftMax, -1);
        Arrays.fill(rightMax, n);

        Deque<Integer> stack = new ArrayDeque<>();
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && A[stack.peek()] > A[i]) {
                rightMin[stack.pop()] = i;
            }
            leftMin[i] = stack.isEmpty() ? -1 : stack.peek();
            stack.push(i);
        }

        stack.clear();
        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && A[stack.peek()] < A[i]) {
                rightMax[stack.pop()] = i;
            }
            leftMax[i] = stack.isEmpty() ? -1 : stack.peek();
            stack.push(i);
        }

        long[] prefix = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + A[i];
        }

        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + prefix[i + 1];
        }

        long result = 0;
        for (int i = 0; i < n; i++) {
            int l = leftMin[i] + 1;
            int r = rightMin[i] - 1;
            int l2 = leftMax[i] + 1;
            int r2 = rightMax[i] - 1;

            long sumMin = (long) A[i] * (r - l + 1) * (r - l + 2) / 2;
            long sumMinPrefix = prefixSum[r + 1] - prefixSum[l];
            long sumMinTotal = sumMinPrefix - (long) A[i] * (r - l + 1);

            long sumMax = (long) A[i] * (r2 - l2 + 1) * (r2 - l2 + 2) / 2;
            long sumMaxPrefix = prefixSum[r2 + 1] - prefixSum[l2];
            long sumMaxTotal = sumMaxPrefix - (long) A[i] * (r2 - l2 + 1);

            result += (sumMaxTotal - sumMinTotal);
        }

        return new int[]{(int) (result % (1000000007))};
    }
}
}