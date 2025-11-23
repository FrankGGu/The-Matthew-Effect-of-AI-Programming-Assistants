import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int[] recoverArray(int n, int[] sums) {
        Arrays.sort(sums);
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int sum : sums) {
            countMap.put(sum, countMap.getOrDefault(sum, 0) + 1);
        }

        int[] result = new int[n];
        for (int diff = 1; diff <= 100000; diff++) {
            if (countMap.getOrDefault(0, 0) % 2 != 0) continue;

            int[] temp = new int[n];
            int idx = 0;
            for (int i = 0; i < n; i++) {
                if (countMap.getOrDefault(0, 0) > 0) {
                    temp[idx++] = diff;
                    countMap.put(0, countMap.get(0) - 1);
                } else if (countMap.getOrDefault(diff, 0) > 0) {
                    temp[idx++] = diff;
                    countMap.put(diff, countMap.get(diff) - 1);
                } else {
                    break;
                }
            }
            if (idx == n) {
                return temp;
            }
        }
        return new int[0];
    }
}