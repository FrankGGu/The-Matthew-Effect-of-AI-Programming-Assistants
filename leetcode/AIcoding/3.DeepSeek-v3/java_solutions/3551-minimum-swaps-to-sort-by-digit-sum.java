import java.util.*;

class Solution {
    public int minimumSwaps(int[] nums) {
        int n = nums.length;
        int[] digitSums = new int[n];
        for (int i = 0; i < n; i++) {
            digitSums[i] = getDigitSum(nums[i]);
        }

        int[] sortedIndices = new int[n];
        for (int i = 0; i < n; i++) {
            sortedIndices[i] = i;
        }

        Arrays.sort(sortedIndices, (a, b) -> {
            if (digitSums[a] != digitSums[b]) {
                return Integer.compare(digitSums[a], digitSums[b]);
            } else {
                return Integer.compare(a, b);
            }
        });

        boolean[] visited = new boolean[n];
        int swaps = 0;

        for (int i = 0; i < n; i++) {
            if (visited[i] || sortedIndices[i] == i) {
                continue;
            }

            int cycleSize = 0;
            int j = i;
            while (!visited[j]) {
                visited[j] = true;
                j = sortedIndices[j];
                cycleSize++;
            }

            if (cycleSize > 0) {
                swaps += (cycleSize - 1);
            }
        }

        return swaps;
    }

    private int getDigitSum(int num) {
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum;
    }
}