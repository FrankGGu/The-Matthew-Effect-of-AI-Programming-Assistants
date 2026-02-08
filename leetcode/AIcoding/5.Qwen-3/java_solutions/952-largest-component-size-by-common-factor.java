public class Solution {

import java.util.*;

public class Solution {
    public int largestComponentSize(int[] nums) {
        UnionFind uf = new UnionFind(nums.length);
        Map<Integer, Integer> factorMap = new HashMap<>();

        for (int i = 0; i < nums.length; i++) {
            int num = nums[i];
            if (num == 1) continue;
            Set<Integer> factors = getFactors(num);
            for (int f : factors) {
                if (factorMap.containsKey(f)) {
                    uf.union(i, factorMap.get(f));
                } else {
                    factorMap.put(f, i);
                }
            }
        }

        int[] count = new int[nums.length];
        int max = 0;
        for (int i = 0; i < nums.length; i++) {
            int root = uf.find(i);
            count[root]++;
            max = Math.max(max, count[root]);
        }

        return max;
    }

    private Set<Integer> getFactors(int n) {
        Set<Integer> factors = new HashSet<>();
        for (int i = 2; i * i <= n; i++) {
            if (n % i == 0) {
                factors.add(i);
                factors.add(n / i);
            }
        }
        if (n > 1) factors.add(n);
        return factors;
    }

    static class UnionFind {
        int[] parent;

        public UnionFind(int size) {
            parent = new int[size];
            for (int i = 0; i < size; i++) {
                parent[i] = i;
            }
        }

        public int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        public void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootX] = rootY;
            }
        }
    }
}
}