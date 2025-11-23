class Solution {
    public int minSwaps(String s) {
        int count0 = 0, count1 = 0;
        for (char c : s.toCharArray()) {
            if (c == '0') {
                count0++;
            } else {
                count1++;
            }
        }

        if (Math.abs(count0 - count1) > 1) {
            return -1;
        }

        if (count0 > count1) {
            return countSwaps(s, '0');
        } else if (count1 > count0) {
            return countSwaps(s, '1');
        } else {
            return Math.min(countSwaps(s, '0'), countSwaps(s, '1'));
        }
    }

    private int countSwaps(String s, char start) {
        int swaps = 0;
        for (char c : s.toCharArray()) {
            if (c != start) {
                swaps++;
            }
            start = (start == '0') ? '1' : '0';
        }
        return swaps / 2;
    }
}