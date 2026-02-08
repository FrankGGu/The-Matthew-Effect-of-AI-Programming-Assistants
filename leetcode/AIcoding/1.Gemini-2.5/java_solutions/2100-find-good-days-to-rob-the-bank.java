import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> goodDaysToRobBank(int[] security, int time) {
        int n = security.length;
        if (n < 2 * time + 1) {
            return new ArrayList<>();
        }

        int[] left = new int[n];
        left[0] = 0;

        for (int i = 1; i < n; i++) {
            if (security[i - 1] >= security[i]) {
                left[i] = left[i - 1] + 1;
            } else {
                left[i] = 0;
            }
        }

        int[] right = new int[n];
        right[n - 1] = 0;

        for (int i = n - 2; i >= 0; i--) {
            if (security[i] <= security[i + 1]) {
                right[i] = right[i + 1] + 1;
            } else {
                right[i] = 0;
            }
        }

        List<Integer> result = new ArrayList<>();
        for (int i = time; i < n - time; i++) {
            if (left[i] >= time && right[i] >= time) {
                result.add(i);
            }
        }

        return result;
    }
}