public class Solution {

import java.util.*;

public class Solution {
    public int beautifulPairs(List<Integer> a, List<Integer> b, int n, int m) {
        Map<Integer, Integer> countB = new HashMap<>();
        for (int num : b) {
            countB.put(num, countB.getOrDefault(num, 0) + 1);
        }

        int result = 0;
        Set<Integer> used = new HashSet<>();

        for (int i = 0; i < n; i++) {
            int numA = a.get(i);
            if (countB.containsKey(numA) && !used.contains(numA)) {
                result++;
                used.add(numA);
            }
        }

        return result;
    }
}
}