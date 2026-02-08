public class Solution {
    public int minSwaps(String s) {
        int n = s.length();
        int count0 = 0, count1 = 0;

        for (char c : s.toCharArray()) {
            if (c == '0') count0++;
            else count1++;
        }

        if (Math.abs(count0 - count1) > 1) return -1;

        int swaps1 = 0, swaps2 = 0;

        for (int i = 0; i < n; i++) {
            char expected1 = (i % 2 == 0) ? '0' : '1';
            char expected2 = (i % 2 == 0) ? '1' : '0';
            if (s.charAt(i) != expected1) swaps1++;
            if (s.charAt(i) != expected2) swaps2++;
        }

        if (count0 > count1) {
            return swaps2 / 2;
        } else if (count1 > count0) {
            return swaps1 / 2;
        } else {
            return Math.min(swaps1, swaps2) / 2;
        }
    }
}