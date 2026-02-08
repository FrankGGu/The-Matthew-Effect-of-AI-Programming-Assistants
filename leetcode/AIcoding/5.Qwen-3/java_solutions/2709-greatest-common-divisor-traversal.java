public class Solution {

import java.util.*;

public class Solution {
    public boolean canTraverseGrid(int[] nums) {
        int n = nums.length;
        if (n == 1) return true;

        Set<Integer> primes = new HashSet<>();
        Map<Integer, List<Integer>> primeToIndices = new HashMap<>();

        for (int i = 0; i < n; i++) {
            int num = nums[i];
            Set<Integer> factors = getPrimeFactors(num);
            for (int p : factors) {
                primes.add(p);
                primeToIndices.putIfAbsent(p, new ArrayList<>());
                primeToIndices.get(p).add(i);
            }
        }

        UnionFind uf = new UnionFind(n);

        for (Map.Entry<Integer, List<Integer>> entry : primeToIndices.entrySet()) {
            List<Integer> indices = entry.getValue();
            for (int i = 1; i < indices.size(); i++) {
                uf.union(indices.get(0), indices.get(i));
            }
        }

        int root = uf.find(0);
        for (int i = 1; i < n; i++) {
            if (uf.find(i) != root) {
                return false;
            }
        }

        return true;
    }

    private Set<Integer> getPrimeFactors(int num) {
        Set<Integer> factors = new HashSet<>();
        int i = 2;
        while (i * i <= num) {
            if (num % i == 0) {
                factors.add(i);
                while (num % i == 0) {
                    num /= i;
                }
            }
            i++;
        }
        if (num > 1) {
            factors.add(num);
        }
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