public class Solution {

import java.util.*;

public class Solution {
    public int minimumSwaps(int[] nums) {
        int n = nums.length;
        int[] digitSums = new int[n];
        for (int i = 0; i < n; i++) {
            int sum = 0;
            int num = nums[i];
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            digitSums[i] = sum;
        }

        int[][] arr = new int[n][2];
        for (int i = 0; i < n; i++) {
            arr[i][0] = digitSums[i];
            arr[i][1] = nums[i];
        }

        Arrays.sort(arr, (a, b) -> a[0] != b[0] ? a[0] - b[0] : a[1] - b[1]);

        int[] indexMap = new int[n];
        for (int i = 0; i < n; i++) {
            indexMap[arr[i][1]] = i;
        }

        boolean[] visited = new boolean[n];
        int swaps = 0;

        for (int i = 0; i < n; i++) {
            if (visited[i]) continue;
            int j = i;
            int cycleSize = 0;
            while (!visited[j]) {
                visited[j] = true;
                j = indexMap[nums[j]];
                cycleSize++;
            }
            if (cycleSize > 1) {
                swaps += (cycleSize - 1);
            }
        }

        return swaps;
    }
}
}