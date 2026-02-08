import java.util.*;

class Solution {

    private static final int MAX_VAL = 100000;
    private static int[] spf; // Smallest Prime Factor

    // Static initializer block for sieve to precompute SPF array
    static {
        spf = new int[MAX_VAL + 1];
        for (int i = 2; i <= MAX_VAL; i++) {
            if (spf[i] == 0) { // i is prime
                spf[i] = i;
                for (long j = (long) i * i; j <= MAX_VAL; j += i) {
                    if (spf[(int) j] == 0) {
                        spf[(int) j] = i;
                    }
                }
            }
        }
    }

    // Helper method to get distinct prime factors of a number using the precomputed SPF array
    private List<Integer> getPrimeFactors(int n) {
        List<Integer> factors = new ArrayList<>();
        if (n <= 1) return factors; // 0 and 1 have no prime factors relevant to GCD > 1
        while (n > 1) {
            int p = spf[n];
            factors.add(p);
            while (n % p == 0) { // Remove all occurrences of this prime factor
                n /= p;
            }
        }
        return factors;
    }

    public boolean gcdSort(int[] nums) {
        int n = nums.length;

        // Optimization: If the array is already sorted, no operations are needed.
        boolean alreadySorted = true;
        for (int i = 0; i < n - 1; i++) {
            if (nums[i] > nums[i + 1]) {
                alreadySorted = false;
                break;
            }
        }
        if (alreadySorted) {
            return true;
        }

        DSU dsu = new DSU(n);
        // Map to store a prime factor and an index in `nums` that contains this prime factor.
        // This index acts as a representative for connecting other numbers sharing the same prime.
        Map<Integer, Integer> primeToIdxMap = new HashMap<>(); 

        for (int i = 0; i < n; i++) {
            int num = nums[i];
            List<Integer> factors = getPrimeFactors(num);
            for (int p : factors) {
                if (primeToIdxMap.containsKey(p)) {
                    dsu.union(i, primeToIdxMap.get(p));
                } else {
                    primeToIdxMap.put(p, i);
                }
            }
        }

        // Group indices and values by their DSU root (i.e., by connected component)
        Map<Integer, List<Integer>> componentsIndices = new HashMap<>();
        Map<Integer, List<Integer>> componentsValues = new HashMap<>();

        for (int i = 0; i < n; i++) {
            int root = dsu.find(i);
            componentsIndices.computeIfAbsent(root, k -> new ArrayList<>()).add(i);
            componentsValues.computeIfAbsent(root, k -> new ArrayList<>()).add(nums[i]);
        }

        // Reconstruct the array by sorting values within each component and placing them
        // back into their original positions (which are also sorted)
        int[] result = new int[n];
        for (int root : componentsIndices.keySet()) {
            List<Integer> indices = componentsIndices.get(root);
            List<Integer> values = componentsValues.get(root);

            // Sort both the original indices and the values within this component
            Collections.sort(indices);
            Collections.sort(values);

            // Place the sorted values back into the result array at their sorted original indices
            for (int i = 0; i < indices.size(); i++) {
                result[indices.get(i)] = values.get(i);
            }
        }

        // Finally, check if the reconstructed array is globally sorted
        for (int i = 0; i < n - 1; i++) {
            if (result[i] > result[i + 1]) {
                return false;
            }
        }

        return true;
    }

    // Disjoint Set Union (DSU) class with path compression and union by size
    private static class DSU {
        int[] parent;
        int[] size;

        public DSU(int n) {
            parent = new int[n];
            size = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
                size[i] = 1;
            }
        }

        public int find(int i) {
            if (parent[i] == i) {
                return i;
            }
            return parent[i] = find(parent[i]); // Path compression
        }

        public void union(int i, int j) {
            int rootI = find(i);
            int rootJ = find(j);
            if (rootI != rootJ) {
                // Union by size: attach smaller tree under root of larger tree
                if (size[rootI] < size[rootJ]) {
                    int temp = rootI;
                    rootI = rootJ;
                    rootJ = temp;
                }
                parent[rootJ] = rootI;
                size[rootI] += size[rootJ];
            }
        }
    }
}