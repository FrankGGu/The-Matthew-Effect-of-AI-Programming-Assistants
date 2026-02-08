import java.util.*;

class FallingSquares {
    private List<int[]> squares;

    public FallingSquares() {
        squares = new ArrayList<>();
    }

    public List<Integer> fallSquares(int[][] positions) {
        List<Integer> heights = new ArrayList<>();
        int maxHeight = 0;

        for (int[] position : positions) {
            int left = position[0];
            int size = position[1];
            int right = left + size;
            int height = 0;

            for (int[] square : squares) {
                int squareLeft = square[0];
                int squareRight = squareLeft + square[1];
                if (right > squareLeft && left < squareRight) {
                    height = Math.max(height, square[1]);
                }
            }

            height += 1;
            maxHeight = Math.max(maxHeight, height);
            squares.add(new int[]{left, height});
            heights.add(maxHeight);
        }

        return heights;
    }
}