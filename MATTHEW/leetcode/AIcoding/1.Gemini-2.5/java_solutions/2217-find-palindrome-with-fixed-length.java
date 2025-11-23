class Solution {
    public long[] kthPalindrome(int[] queries, int intLength) {
        long[] results = new long[queries.length];

        int halfLen = (intLength + 1) / 2;

        long startNum = 1;
        for (int i = 0; i < halfLen - 1; i++) {
            startNum *= 10;
        }

        long endNum = startNum * 10 - 1;

        for (int i = 0; i < queries.length; i++) {
            long query = queries[i];
            long baseNum = startNum + query - 1;

            if (baseNum > endNum) {
                results[i] = -1;
            } else {
                String firstHalfStr = String.valueOf(baseNum);
                StringBuilder sb = new StringBuilder(firstHalfStr);
                String secondHalfStr;

                if (intLength % 2 == 0) {
                    secondHalfStr = sb.reverse().toString();
                } else {
                    secondHalfStr = sb.reverse().toString().substring(1);
                }

                String palindromeStr = firstHalfStr + secondHalfStr;
                results[i] = Long.parseLong(palindromeStr);
            }
        }

        return results;
    }
}