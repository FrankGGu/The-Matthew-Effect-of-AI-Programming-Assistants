import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

class Solution {
    public int[] findEvenNumbers(int[] digits) {
        int[] availableCounts = new int[10];
        for (int digit : digits) {
            availableCounts[digit]++;
        }

        Set<Integer> uniqueEvenNumbers = new HashSet<>();

        for (int i = 100; i <= 998; i += 2) {
            int d1 = i / 100;
            int d2 = (i / 10) % 10;
            int d3 = i % 10;

            int[] requiredCounts = new int[10];
            requiredCounts[d1]++;
            requiredCounts[d2]++;
            requiredCounts[d3]++;

            boolean canForm = true;
            for (int d = 0; d < 10; d++) {
                if (requiredCounts[d] > availableCounts[d]) {
                    canForm = false;
                    break;
                }
            }

            if (canForm) {
                uniqueEvenNumbers.add(i);
            }
        }

        int[] result = new int[uniqueEvenNumbers.size()];
        int idx = 0;
        for (int num : uniqueEvenNumbers) {
            result[idx++] = num;
        }
        Arrays.sort(result);

        return result;
    }
}