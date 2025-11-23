import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public double findMedian(int[] nums) {
        Map<Integer, Integer> counts = new HashMap<>();
        for (int num : nums) {
            counts.put(num, counts.getOrDefault(num, 0) + 1);
        }

        int[] uniqueNums = new int[counts.size()];
        int index = 0;
        for (int num : counts.keySet()) {
            uniqueNums[index++] = num;
        }

        Arrays.sort(uniqueNums);

        int n = uniqueNums.length;
        if (n % 2 == 0) {
            return (double) (uniqueNums[n / 2 - 1] + uniqueNums[n / 2]) / 2;
        } else {
            return (double) uniqueNums[n / 2];
        }
    }
}