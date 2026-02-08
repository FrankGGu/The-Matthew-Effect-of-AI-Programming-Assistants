public class Solution {

import java.util.*;

public class Solution {
    public int[] findPermutation(String s) {
        int n = s.length();
        int[] result = new int[n + 1];
        Arrays.fill(result, 0);

        int index = 0;
        for (int i = 0; i <= n; i++) {
            if (i == n || s.charAt(i) == 'I') {
                for (int j = i; j >= index; j--) {
                    result[j] = i - j + 1;
                }
                index = i + 1;
            }
        }

        return result;
    }
}
}