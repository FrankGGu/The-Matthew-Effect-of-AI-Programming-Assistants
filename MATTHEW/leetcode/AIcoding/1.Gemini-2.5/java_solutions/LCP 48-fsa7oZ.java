class Solution {
    public int[] solve(int[][] queries) {
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int r = queries[i][0];
            int c = queries[i][1];

            // The problem states that cells are colored 1 or 0 alternatingly
            // along the spiral path, starting with (0, 0) as 1.
            // This pattern corresponds to a standard chessboard coloring,
            // where the color depends on the parity of the sum of coordinates (r + c).
            // If (r + c) is even, the cell has the same color as (0, 0), which is 1.
            // If (r + c) is odd, the cell has the alternating color, which is 0.
            // The modulo operator (%) in Java handles negative numbers such that
            // an even number modulo 2 is 0, and an odd number modulo 2 is 1 or -1.
            // Checking for `== 0` correctly identifies even sums.
            if ((r + c) % 2 == 0) {
                result[i] = 1;
            } else {
                result[i] = 0;
            }
        }
        return result;
    }
}