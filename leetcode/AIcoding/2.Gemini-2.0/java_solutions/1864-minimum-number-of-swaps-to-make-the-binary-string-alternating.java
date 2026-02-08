class Solution {
    public int minSwaps(String s) {
        int zeros = 0;
        int ones = 0;
        for (char c : s.toCharArray()) {
            if (c == '0') {
                zeros++;
            } else {
                ones++;
            }
        }

        if (Math.abs(zeros - ones) > 1) {
            return -1;
        }

        if (zeros > ones) {
            return calculateSwaps(s, '0');
        } else if (ones > zeros) {
            return calculateSwaps(s, '1');
        } else {
            return Math.min(calculateSwaps(s, '0'), calculateSwaps(s, '1'));
        }
    }

    private int calculateSwaps(String s, char start) {
        int swaps = 0;
        for (int i = 0; i < s.length(); i++) {
            char expected = (i % 2 == 0) ? start : (start == '0' ? '1' : '0');
            if (s.charAt(i) != expected) {
                swaps++;
            }
        }
        return swaps / 2;
    }
}