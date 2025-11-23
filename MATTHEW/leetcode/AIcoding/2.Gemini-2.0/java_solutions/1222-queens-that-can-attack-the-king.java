import java.util.*;

class Solution {
    public List<List<Integer>> queensAttacktheKing(int[][] queens, int[] king) {
        Set<String> queenSet = new HashSet<>();
        for (int[] queen : queens) {
            queenSet.add(queen[0] + "," + queen[1]);
        }

        List<List<Integer>> result = new ArrayList<>();

        int[] dx = {-1, -1, -1, 0, 0, 1, 1, 1};
        int[] dy = {-1, 0, 1, -1, 1, -1, 0, 1};

        for (int i = 0; i < 8; i++) {
            int x = king[0] + dx[i];
            int y = king[1] + dy[i];

            while (x >= 0 && x < 8 && y >= 0 && y < 8) {
                if (queenSet.contains(x + "," + y)) {
                    result.add(Arrays.asList(x, y));
                    break;
                }
                x += dx[i];
                y += dy[i];
            }
        }

        return result;
    }
}