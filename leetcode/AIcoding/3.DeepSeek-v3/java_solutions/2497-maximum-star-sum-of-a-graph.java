class Solution {
    public int maxStarSum(int[] vals, int[][] edges, int k) {
        int n = vals.length;
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }
        int maxSum = Integer.MIN_VALUE;
        for (int i = 0; i < n; i++) {
            List<Integer> neighbors = graph.get(i);
            List<Integer> neighborVals = new ArrayList<>();
            for (int neighbor : neighbors) {
                neighborVals.add(vals[neighbor]);
            }
            Collections.sort(neighborVals, Collections.reverseOrder());
            int currentSum = vals[i];
            int count = 0;
            for (int val : neighborVals) {
                if (val <= 0 || count >= k) {
                    break;
                }
                currentSum += val;
                count++;
            }
            maxSum = Math.max(maxSum, currentSum);
        }
        return maxSum;
    }
}