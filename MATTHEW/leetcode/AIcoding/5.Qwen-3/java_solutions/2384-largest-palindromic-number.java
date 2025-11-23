public class Solution {

import java.util.*;

public class Solution {
    public String largestPalindromic(String num) {
        int[] count = new int[10];
        for (char c : num.toCharArray()) {
            count[c - '0']++;
        }

        StringBuilder left = new StringBuilder();
        StringBuilder right = new StringBuilder();
        boolean hasMiddle = false;

        for (int i = 9; i >= 0; i--) {
            if (count[i] > 0) {
                if (i == 0 && left.length() == 0) {
                    continue;
                }
                int times = count[i] / 2;
                for (int j = 0; j < times; j++) {
                    left.append(i);
                    right.append(i);
                }
                count[i] %= 2;
            }
        }

        for (int i = 9; i >= 0; i--) {
            if (count[i] > 0) {
                left.append(i);
                hasMiddle = true;
                break;
            }
        }

        if (left.length() == 0) {
            return "0";
        }

        right.reverse();
        left.append(right);

        return left.toString();
    }
}
}