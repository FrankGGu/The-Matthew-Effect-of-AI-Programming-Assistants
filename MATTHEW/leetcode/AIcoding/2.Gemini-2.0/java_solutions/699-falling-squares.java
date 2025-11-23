import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> fallingSquares(int[][] positions) {
        List<int[]> squares = new ArrayList<>();
        List<Integer> heights = new ArrayList<>();
        int maxHeight = 0;

        for (int[] position : positions) {
            int left = position[0];
            int side = position[1];
            int right = left + side;

            int currentHeight = side;
            for (int[] square : squares) {
                int squareLeft = square[0];
                int squareRight = square[1];
                int squareHeight = square[2];

                if (right > squareLeft && left < squareRight) {
                    currentHeight = Math.max(currentHeight, squareHeight + side);
                }
            }

            squares.add(new int[]{left, right, side});
            maxHeight = Math.max(maxHeight, currentHeight);
            heights.add(maxHeight);
        }

        return heights;
    }
}