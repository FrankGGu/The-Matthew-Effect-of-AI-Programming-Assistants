class Solution {
    public long[] kthPalindrome(int[] queries, int intLength) {
        long[] res = new long[queries.length];
        int halfLength = (intLength + 1) / 2;
        long start = (long) Math.pow(10, halfLength - 1);
        long end = (long) Math.pow(10, halfLength) - 1;

        for (int i = 0; i < queries.length; i++) {
            int q = queries[i];
            if (q > (end - start + 1)) {
                res[i] = -1;
                continue;
            }
            long half = start + q - 1;
            String halfStr = Long.toString(half);
            String palindromeStr;
            if (intLength % 2 == 0) {
                palindromeStr = halfStr + new StringBuilder(halfStr).reverse().toString();
            } else {
                palindromeStr = halfStr + new StringBuilder(halfStr.substring(0, halfStr.length() - 1)).reverse().toString();
            }
            res[i] = Long.parseLong(palindromeStr);
        }
        return res;
    }
}