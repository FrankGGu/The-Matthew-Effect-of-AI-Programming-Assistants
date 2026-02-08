import java.util.HashMap;
import java.util.Map;

class Solution {
    public int countLargestGroup(int n) {
        Map<Integer, Integer> sumCount = new HashMap<>();
        int maxSumCount = 0;
        int count = 0;

        for (int i = 1; i <= n; i++) {
            int sum = 0;
            int temp = i;
            while (temp > 0) {
                sum += temp % 10;
                temp /= 10;
            }

            sumCount.put(sum, sumCount.getOrDefault(sum, 0) + 1);
            if (sumCount.get(sum) > maxSumCount) {
                maxSumCount = sumCount.get(sum);
                count = 1;
            } else if (sumCount.get(sum) == maxSumCount) {
                count++;
            }
        }

        return count;
    }
}