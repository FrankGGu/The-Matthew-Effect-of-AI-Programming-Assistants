class Solution {
    public int heightChecker(int[] heights) {
        int[] count = new int[101];
        for (int height : heights) {
            count[height]++;
        }

        int expectedHeight = 0, moves = 0;
        for (int i = 0; i < heights.length; i++) {
            while (count[expectedHeight] == 0) {
                expectedHeight++;
            }
            if (heights[i] != expectedHeight) {
                moves++;
            }
            count[expectedHeight]--;
        }

        return moves;
    }
}