import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<List<Integer>> queensAttacktheKing(int[][] queens, int[] king) {
        boolean[][] board = new boolean[8][8];
        for (int[] queen : queens) {
            board[queen[0]][queen[1]] = true;
        }

        List<List<Integer>> result = new ArrayList<>();
        int[][] directions = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}};

        for (int[] dir : directions) {
            int x = king[0], y = king[1];
            while (x >= 0 && x < 8 && y >= 0 && y < 8) {
                if (board[x][y]) {
                    List<Integer> queenPos = new ArrayList<>();
                    queenPos.add(x);
                    queenPos.add(y);
                    result.add(queenPos);
                    break;
                }
                x += dir[0];
                y += dir[1];
            }
        }

        return result;
    }
}