class Solution {
    public int[] cycleLengthQueries(int n, int[][] queries) {
        int[] result = new int[queries.length];

        for (int i = 0; i < queries.length; i++) {
            int u = queries[i][0];
            int v = queries[i][1];
            int length = 0;

            while (u != v) {
                if (u > v) {
                    u /= 2;
                } else {
                    v /= 2;
                }
                length++;
            }
            result[i] = length + 1;
        }

        return result;
    }
}