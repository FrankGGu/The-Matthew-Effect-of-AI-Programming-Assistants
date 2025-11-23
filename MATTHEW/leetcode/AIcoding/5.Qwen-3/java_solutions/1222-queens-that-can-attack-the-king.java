public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> queensAttacktheKing(int[][] queens, int[] king) {
        int[][] directions = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};
        Set<String> queenSet = new HashSet<>();
        for (int[] queen : queens) {
            queenSet.add(queen[0] + "," + queen[1]);
        }
        List<List<Integer>> result = new ArrayList<>();
        for (int[] dir : directions) {
            int x = king[0], y = king[1];
            while (x >= 0 && x < 8 && y >= 0 && y < 8) {
                x += dir[0];
                y += dir[1];
                if (queenSet.contains(x + "," + y)) {
                    result.add(Arrays.asList(x, y));
                    break;
                }
            }
        }
        return result;
    }
}
}