import java.util.ArrayList;
import java.util.List;

class Solution {
    public int countHighestScoreNodes(int[] parents) {
        int n = parents.length;
        List<List<Integer>> tree = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            tree.add(new ArrayList<>());
        }
        for (int i = 1; i < n; i++) {
            tree.get(parents[i]).add(i);
        }

        long maxScore = 0;
        int count = 0;

        for (int i = 0; i < n; i++) {
            long score = 1;
            for (int child : tree.get(i)) {
                score *= subtreeSize(child);
            }
            if (i != 0) score *= (n - subtreeSize(i));
            if (score > maxScore) {
                maxScore = score;
                count = 1;
            } else if (score == maxScore) {
                count++;
            }
        }

        return count;
    }

    private int subtreeSize(int node) {
        if (node == -1) return 0;
        int size = 1;
        for (int child : tree.get(node)) {
            size += subtreeSize(child);
        }
        return size;
    }
}