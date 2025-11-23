public class Solution {
    public String nearestPalindrome(String n) {
        int len = n.length();
        long num = Long.parseLong(n);
        long[] candidates = new long[len + 1];
        long prefix = Long.parseLong(n.substring(0, (len + 1) / 2));

        for (int i = 0; i < len + 1; i++) {
            if (i == 0) {
                candidates[0] = 10;
            } else if (i == len) {
                candidates[i] = 100;
            } else {
                long p = prefix + (i - 1);
                String left = String.valueOf(p);
                String right = new StringBuilder(left).reverse().toString();
                candidates[i] = Long.parseLong(left + right);
            }
        }

        long minDiff = Long.MAX_VALUE;
        long result = 0;
        for (long candidate : candidates) {
            if (candidate == num) continue;
            long diff = Math.abs(candidate - num);
            if (diff < minDiff) {
                minDiff = diff;
                result = candidate;
            } else if (diff == minDiff && candidate < result) {
                result = candidate;
            }
        }

        return String.valueOf(result);
    }
}