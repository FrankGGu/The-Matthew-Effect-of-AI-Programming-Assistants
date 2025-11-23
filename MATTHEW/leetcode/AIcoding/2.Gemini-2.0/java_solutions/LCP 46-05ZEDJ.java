import java.util.*;

class Solution {
    public int[] volunteerDeployment(int[] finalCnt, long totalNum, int[][] edges, int[][] plans) {
        int n = finalCnt.length;
        List<Integer>[] adj = new List[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0] - 1;
            int v = edge[1] - 1;
            adj[u].add(v);
            adj[v].add(u);
        }

        long[] diff = new long[n];
        long sum = 0;
        for (int i = 0; i < n; i++) {
            diff[i] = finalCnt[i];
            sum += finalCnt[i];
        }

        for (int i = plans.length - 1; i >= 0; i--) {
            int type = plans[i][0];
            int index = plans[i][1] - 1;
            int val = 0;
            if (plans[i].length == 3) {
                val = plans[i][2];
            }

            if (type == 1) {
                diff[index] -= val;
                sum -= val;
            } else if (type == 2) {
                diff[index] += val * (adj[index].size() + 1);
                sum += val * (adj[index].size() + 1);
                for (int neighbor : adj[index]) {
                    diff[neighbor] -= val;
                    sum -= val;
                }
            } else {
                diff[index] -= val * (adj[index].size() + 1);
                sum -= val * (adj[index].size() + 1);
                for (int neighbor : adj[index]) {
                    diff[neighbor] += val;
                    sum += val;
                }
            }
        }

        long a = 0;
        long b = 0;
        for (int i = 0; i < n; i++) {
            if (adj[i].size() == 0) {
                a++;
                b += diff[i];
            } else {
                a += adj[i].size() + 1;
                b += diff[i];
            }
        }

        long x = (totalNum - b) / a;

        int[] res = new int[n];
        for (int i = 0; i < n; i++) {
            if (adj[i].size() == 0) {
                res[i] = (int) (x + diff[i]);
            } else {
                res[i] = (int) (x + diff[i]);
            }
        }

        return res;
    }
}