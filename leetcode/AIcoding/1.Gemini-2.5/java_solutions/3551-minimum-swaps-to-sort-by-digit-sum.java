import java.util.Arrays;
import java.util.Comparator;

class Solution {

    private static class ElementInfo {
        int value;
        int digitSum;
        int originalIndex;

        ElementInfo(int v, int ds, int oi) {
            this.value = v;
            this.digitSum = ds;
            this.originalIndex = oi;
        }
    }

    private int calculateDigitSum(int n) {
        int sum = 0;
        while (n > 0) {
            sum += n % 10;
            n /= 10;
        }
        return sum;
    }

    public int minimumSwaps(int[] nums) {
        int n = nums.length;
        ElementInfo[] elements = new ElementInfo[n];

        for (int i = 0; i < n; i++) {
            int ds = calculateDigitSum(nums[i]);
            elements[i] = new ElementInfo(nums[i], ds, i);
        }

        Arrays.sort(elements, (a, b) -> {
            if (a.digitSum != b.digitSum) {
                return Integer.compare(a.digitSum, b.digitSum);
            }
            return Integer.compare(a.value, b.value);
        });

        int swaps = 0;
        boolean[] visited = new boolean[n];

        for (int i = 0; i < n; i++) {
            if (visited[i] || elements[i].originalIndex == i) {
                continue;
            }

            int cycle_len = 0;
            int current_idx = i;
            while (!visited[current_idx]) {
                visited[current_idx] = true;
                current_idx = elements[current_idx].originalIndex;
                cycle_len++;
            }
            swaps += (cycle_len - 1);
        }

        return swaps;
    }
}