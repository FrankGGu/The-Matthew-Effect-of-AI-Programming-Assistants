import java.util.ArrayList;
import java.util.List;

class BlockPlacementQueries {
    public List<Integer> blockPlacementQueries(int[][] blocks, int[][] queries) {
        int n = blocks.length;
        int[] blockCount = new int[n + 1];
        for (int[] block : blocks) {
            blockCount[block[0]]++;
            if (block[1] + 1 <= n) blockCount[block[1] + 1]--;
        }

        for (int i = 1; i <= n; i++) {
            blockCount[i] += blockCount[i - 1];
        }

        List<Integer> result = new ArrayList<>();
        for (int[] query : queries) {
            result.add(blockCount[query[1]] - blockCount[query[0] - 1]);
        }

        return result;
    }
}