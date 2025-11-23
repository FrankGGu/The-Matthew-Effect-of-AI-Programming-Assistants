public class Solution {

import java.util.Arrays;

public class Solution {
    public int oddEvenJumps(int[] arr) {
        int n = arr.length;
        boolean[] canReachOdd = new boolean[n];
        boolean[] canReachEven = new boolean[n];
        canReachOdd[n - 1] = true;
        canReachEven[n - 1] = true;

        int[] sortedIndices = new int[n];
        for (int i = 0; i < n; i++) {
            sortedIndices[i] = i;
        }

        Arrays.sort(sortedIndices, (a, b) -> arr[a] - arr[b]);

        int[] nextHigher = new int[n];
        Arrays.fill(nextHigher, -1);
        for (int i = 0; i < n - 1; i++) {
            if (arr[sortedIndices[i]] < arr[sortedIndices[i + 1]]) {
                nextHigher[sortedIndices[i]] = sortedIndices[i + 1];
            }
        }

        int[] nextLower = new int[n];
        Arrays.fill(nextLower, -1);
        for (int i = 0; i < n - 1; i++) {
            if (arr[sortedIndices[i]] > arr[sortedIndices[i + 1]]) {
                nextLower[sortedIndices[i]] = sortedIndices[i + 1];
            }
        }

        for (int i = n - 2; i >= 0; i--) {
            int nextHigh = nextHigher[i];
            if (nextHigh != -1) {
                canReachOdd[i] = canReachEven[nextHigh];
            }

            int nextLow = nextLower[i];
            if (nextLow != -1) {
                canReachEven[i] = canReachOdd[nextLow];
            }
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            if (canReachOdd[i]) {
                result++;
            }
        }
        return result;
    }
}
}