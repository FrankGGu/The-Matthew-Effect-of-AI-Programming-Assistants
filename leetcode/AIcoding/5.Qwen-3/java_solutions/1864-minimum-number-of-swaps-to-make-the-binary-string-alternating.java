public class Solution {
    public int minSwapsToMakeAlternating(String s) {
        int n = s.length();
        int count0 = 0, count1 = 0;
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '0') {
                count0++;
            } else {
                count1++;
            }
        }

        if (Math.abs(count0 - count1) > 1) {
            return -1;
        }

        int swap1 = 0, swap2 = 0;
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                if (s.charAt(i) != '0') swap1++;
                if (s.charAt(i) != '1') swap2++;
            } else {
                if (s.charAt(i) != '1') swap1++;
                if (s.charAt(i) != '0') swap2++;
            }
        }

        if (count0 == count1) {
            return Math.min(swap1, swap2);
        } else if (count0 > count1) {
            return swap1;
        } else {
            return swap2;
        }
    }
}