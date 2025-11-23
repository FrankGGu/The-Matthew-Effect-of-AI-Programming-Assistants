public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> decrypt(int[] code, int k) {
        int n = code.length;
        List<Integer> result = new ArrayList<>();

        if (k == 0) {
            for (int i = 0; i < n; i++) {
                result.add(0);
            }
            return result;
        }

        for (int i = 0; i < n; i++) {
            int sum = 0;
            if (k > 0) {
                for (int j = 1; j <= k; j++) {
                    sum += code[(i + j) % n];
                }
            } else {
                for (int j = 1; j <= Math.abs(k); j++) {
                    sum += code[(i - j + n) % n];
                }
            }
            result.add(sum);
        }

        return result;
    }
}
}