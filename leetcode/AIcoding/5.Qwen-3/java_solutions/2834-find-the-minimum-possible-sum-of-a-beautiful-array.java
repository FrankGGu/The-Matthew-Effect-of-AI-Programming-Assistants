public class Solution {

import java.util.*;

public class Solution {
    public int findMinPossibleSum(int n, int k) {
        Set<Integer> used = new HashSet<>();
        List<Integer> arr = new ArrayList<>();

        for (int i = 1; i <= n; i++) {
            if (!used.contains(i)) {
                arr.add(i);
                for (int j = i + k; j <= n; j += k) {
                    used.add(j);
                }
            }
        }

        int sum = 0;
        for (int num : arr) {
            sum += num;
        }
        return sum;
    }
}
}