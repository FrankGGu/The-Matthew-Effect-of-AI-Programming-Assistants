import java.util.ArrayList;
import java.util.List;
import java.util.HashSet;
import java.util.Set;

class Solution {
    private int MAX_VAL = 100000;
    private int[] spf; // smallest prime factor

    // DSU (Disjoint Set Union) class
    class DSU {
        int[] parent;
        int[] size;

        DSU(int n) {
            parent = new int[n];
            size = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
                size[i] = 1;
            }
        }

        int find(int i) {
            if (parent[i] == i) {
                return i;
            }
            return parent[i] = find(parent[i]);
        }

        void union(int i, int j) {
            int rootI = find(i);
            int rootJ = find(j);
            if (rootI != rootJ) {
                // Union by size
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

    // Sieve to precompute smallest prime factors for numbers up to MAX_VAL
    private void sieve() {
        spf = new int[MAX_VAL + 1];
        for (int i = 0; i <= MAX_VAL; i++) {
            spf[i] = i;
        }
        for (int i = 2; i * i <= MAX_VAL; i++) {
            if (spf[i] == i) { // i is prime
                for (int j = i * i; j <= MAX_VAL; j += i) {
                    if (spf[j] == j) { // only update if not already updated by a smaller prime
                        spf[j] = i;
                    }
                }
            }
        }
    }

    // Get distinct prime factors of n using the precomputed spf array
    private List<Integer> getPrimeFactors(int n) {
        List<Integer> factors = new ArrayList<>();
        while (n > 1) {
            int p = spf[n];
            factors.add(p);
            while (n % p == 0) {
                n /= p;
            }
        }
        return factors;
    }

    public boolean canTraverseAllPairs(int[] nums) {
        int n = nums.length;

        if (n == 1) {
            return true;
        }

        // If any '1' exists in nums and n > 1, it cannot connect to any other number
        // because gcd(1, x) = 1. So, it's impossible to traverse all pairs.
        for (int x : nums) {
            if (x == 1) {
                return false;
            }
        }

        sieve(); // Initialize spf array for prime factorization

        // DSU will manage N elements for array indices (0 to N-1)
        // and MAX_VAL elements for prime factors (1 to MAX_VAL).
        // A prime factor 'p' will be mapped to DSU index 'n + p'.
        DSU dsu = new DSU(n + MAX_VAL + 1);

        for (int i = 0; i < n; i++) {
            int num = nums[i];
            List<Integer> factors = getPrimeFactors(num);
            for (int p : factors) {
                // Union the current array index 'i' with its prime factor 'p'.
                // Prime factor 'p' is mapped to DSU index 'n + p'.
                dsu.union(i, n + p);
            }
        }

        // After processing all numbers, check if all original array indices (0 to N-1)
        // belong to the same connected component.
        // We can do this by finding the root of the first index (0) and then
        // verifying if all other indices have the same root.
        int firstRoot = dsu.find(0);
        for (int i = 1; i < n; i++) {
            if (dsu.find(i) != firstRoot) {
                return false;
            }
        }

        return true;
    }
}