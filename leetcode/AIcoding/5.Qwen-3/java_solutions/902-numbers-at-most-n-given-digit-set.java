public class Solution {

import java.util.*;

public class Solution {
    public int numDupDigitsAtMostN(int n, String digits) {
        char[] s = String.valueOf(n).toCharArray();
        int len = s.length;
        Set<Character> set = new HashSet<>();
        for (char c : digits.toCharArray()) {
            set.add(c);
        }
        int res = 0;
        for (int i = 1; i < len; i++) {
            res += permutation(digits.length(), i);
        }
        boolean[] used = new boolean[digits.length()];
        Arrays.sort(digits.toCharArray());
        for (int i = 0; i < len; i++) {
            char c = s[i];
            int count = 0;
            for (int j = 0; j < digits.length(); j++) {
                if (digits.charAt(j) < c && !used[j]) {
                    count++;
                }
            }
            res += count * permutation(digits.length() - 1, len - i - 1);
            if (Arrays.binarySearch(digits.toCharArray(), c) >= 0) {
                used[Arrays.binarySearch(digits.toCharArray(), c)] = true;
            } else {
                break;
            }
            if (i == len - 1) {
                res++;
            }
        }
        return res;
    }

    private int permutation(int n, int k) {
        int res = 1;
        for (int i = 0; i < k; i++) {
            res *= n - i;
        }
        return res;
    }
}
}