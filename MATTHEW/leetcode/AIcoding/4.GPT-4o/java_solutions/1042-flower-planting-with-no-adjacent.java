import java.util.*;

public class Solution {
    public int[] gardenNoAdj(int N, int[][] paths) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < N; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] path : paths) {
            graph.get(path[0] - 1).add(path[1] - 1);
            graph.get(path[1] - 1).add(path[0] - 1);
        }

        int[] result = new int[N];

        for (int i = 0; i < N; i++) {
            boolean[] used = new boolean[5];
            for (int neighbor : graph.get(i)) {
                used[result[neighbor]] = true;
            }
            for (int j = 1; j <= 4; j++) {
                if (!used[j]) {
                    result[i] = j;
                    break;
                }
            }
        }

        return result;
    }
}