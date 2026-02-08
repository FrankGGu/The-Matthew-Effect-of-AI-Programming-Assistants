public class Solution {

import java.util.*;

public class Solution {
    public int countBlackBlocks(int n, int m, int[][] cells) {
        Map<String, Integer> blockCount = new HashMap<>();
        Set<String> blackBlocks = new HashSet<>();

        for (int[] cell : cells) {
            int row = cell[0];
            int col = cell[1];

            for (int dr = 0; dr <= 1; dr++) {
                for (int dc = 0; dc <= 1; dc++) {
                    int r = row + dr;
                    int c = col + dc;

                    if (r >= 0 && r < n && c >= 0 && c < m) {
                        String key = r + "," + c;
                        blockCount.put(key, blockCount.getOrDefault(key, 0) + 1);
                    }
                }
            }
        }

        for (Map.Entry<String, Integer> entry : blockCount.entrySet()) {
            if (entry.getValue() == 4) {
                blackBlocks.add(entry.getKey());
            }
        }

        return blackBlocks.size();
    }
}
}