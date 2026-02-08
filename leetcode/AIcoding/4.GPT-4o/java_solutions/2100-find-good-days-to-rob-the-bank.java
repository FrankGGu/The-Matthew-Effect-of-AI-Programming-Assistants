import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> goodDaysToRobBank(int[] security, int time) {
        List<Integer> result = new ArrayList<>();
        int n = security.length;
        if (time == 0) {
            for (int i = 0; i < n; i++) {
                result.add(i);
            }
            return result;
        }

        int[] nonIncreasing = new int[n];
        for (int i = 1; i < n; i++) {
            if (security[i] <= security[i - 1]) {
                nonIncreasing[i] = nonIncreasing[i - 1] + 1;
            }
        }

        for (int i = time; i < n - time; i++) {
            if (nonIncreasing[i] >= time && nonIncreasing[i + time] >= time) {
                result.add(i);
            }
        }

        return result;
    }
}