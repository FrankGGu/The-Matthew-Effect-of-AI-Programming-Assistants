import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int maxStarSum(int[] vals, int[][] edges, int k) {
        int n = vals.length;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        int maxStarSum = Integer.MIN_VALUE;

        for (int i = 0; i < n; i++) {
            int currentSum = vals[i];

            List<Integer> neighborValues = new ArrayList<>();
            for (int neighbor : adj.get(i)) {
                neighborValues.add(vals[neighbor]);
            }

            neighborValues.sort(Collections.reverseOrder());

            int count = 0;
            for (int neighborVal : neighborValues) {
                if (count < k && neighborVal > 0) {
                    currentSum += neighborVal;
                    count++;
                } else {
                    break; 
                }
            }
            maxStarSum = Math.max(maxStarSum, currentSum);
        }

        return maxStarSum;
    }
}