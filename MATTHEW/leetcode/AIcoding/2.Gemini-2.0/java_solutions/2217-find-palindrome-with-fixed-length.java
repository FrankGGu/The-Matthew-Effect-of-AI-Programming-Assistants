class Solution {
    public long[] kthPalindrome(int[] queries, int intLength) {
        int len = queries.length;
        long[] result = new long[len];
        long start = (long) Math.pow(10, (intLength + 1) / 2 - 1);
        long end = (long) Math.pow(10, (intLength + 1) / 2) - 1;
        long count = end - start + 1;

        for (int i = 0; i < len; i++) {
            long query = queries[i];
            if (query > count) {
                result[i] = -1;
            } else {
                long num = start + query - 1;
                String firstHalf = String.valueOf(num);
                String secondHalf = new StringBuilder(firstHalf).reverse().toString();
                if (intLength % 2 == 0) {
                    result[i] = Long.parseLong(firstHalf + secondHalf);
                } else {
                    result[i] = Long.parseLong(firstHalf + secondHalf.substring(1));
                }
            }
        }
        return result;
    }
}