import java.util.*;

class Solution {
    public int[] gcdSort(int[] nums, int[][] queries) {
        int n = nums.length;
        int m = queries.length;
        int maxVal = 0;
        for (int num : nums) {
            maxVal = Math.max(maxVal, num);
        }

        int[] parent = new int[maxVal + 1];
        for (int i = 0; i <= maxVal; i++) {
            parent[i] = i;
        }

        for (int num : nums) {
            for (int i = 2; i * i <= num; i++) {
                if (num % i == 0) {
                    union(parent, num, i);
                    union(parent, num, num / i);
                }
            }
            for (int i = 2; i <= Math.sqrt(num); i++) {
                if (num % i == 0) {
                    int other = num / i;
                }
            }
        }

        int[] ans = new int[m];
        for (int i = 0; i < m; i++) {
            int u = queries[i][0];
            int v = queries[i][1];
            if (find(parent, u) == find(parent, v)) {
                ans[i] = 1;
            } else {
                ans[i] = 0;
            }
        }
        return ans;
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }

    private void union(int[] parent, int a, int b) {
        int rootA = find(parent, a);
        int rootB = find(parent, b);
        if (rootA != rootB) {
            parent[rootA] = rootB;
        }
    }
}