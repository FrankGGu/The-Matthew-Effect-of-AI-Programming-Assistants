class Solution {
    public int[] volunteerDeployment(int[] finalCount, long totalNum, int[][] edges, int[][] plans) {
        int n = finalCount.length + 1;
        long[] coeff = new long[n];
        long[] constant = new long[n];
        coeff[0] = 1;
        constant[0] = 0;
        for (int i = 1; i < n; i++) {
            coeff[i] = 0;
            constant[i] = finalCount[i - 1];
        }

        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }

        for (int i = plans.length - 1; i >= 0; i--) {
            int num = plans[i][0];
            int idx = plans[i][1];
            if (num == 1) {
                coeff[idx] *= 2;
                constant[idx] *= 2;
            } else {
                for (int neighbor : graph.get(idx)) {
                    if (num == 2) {
                        coeff[neighbor] -= coeff[idx];
                        constant[neighbor] -= constant[idx];
                    } else if (num == 3) {
                        coeff[neighbor] += coeff[idx];
                        constant[neighbor] += constant[idx];
                    }
                }
            }
        }

        long sumCoeff = 0;
        long sumConstant = 0;
        for (int i = 0; i < n; i++) {
            sumCoeff += coeff[i];
            sumConstant += constant[i];
        }
        long x = (totalNum - sumConstant) / sumCoeff;

        int[] res = new int[n];
        for (int i = 0; i < n; i++) {
            res[i] = (int) (coeff[i] * x + constant[i]);
        }
        return res;
    }
}