import java.util.*;

class Solution {
    private static final int MAX_VAL = 100000;
    private int[] parent;
    private int[] rank;
    private int[] smallestPrimeFactor;

    private void sieve() {
        smallestPrimeFactor = new int[MAX_VAL + 1];
        for (int i = 0; i <= MAX_VAL; i++) {
            smallestPrimeFactor[i] = i;
        }

        for (int i = 2; i * i <= MAX_VAL; i++) {
            if (smallestPrimeFactor[i] == i) { // i is prime
                for (int j = i * i; j <= MAX_VAL; j += i) {
                    if (smallestPrimeFactor[j] == j) { // Only update if not already marked by a smaller prime
                        smallestPrimeFactor[j] = i;
                    }
                }
            }
        }
    }

    private void initDSU(int n) {
        parent = new int[n + 1];
        rank = new int[n + 1];
        for (int i = 0; i <= n; i++) {
            parent[i] = i;
            rank[i] = 0;
        }
    }

    private int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    private boolean union(int i, int j) {
        int rootI = find(i);
        int rootJ = find(j);

        if (rootI != rootJ) {
            if (rank[rootI] < rank[rootJ]) {
                parent[rootI] = rootJ;
            } else if (rank[rootJ] < rank[rootI]) {
                parent[rootJ] = rootI;
            } else {
                parent[rootJ] = rootI;
                rank[rootI]++;
            }
            return true;
        }
        return false;
    }

    public int countConnectedComponents(int[] nums) {
        sieve();
        initDSU(MAX_VAL);

        Set<Integer> uniqueNums = new HashSet<>();
        for (int num : nums) {
            uniqueNums.add(num);
        }

        int[] primeToComponentRoot = new int[MAX_VAL + 1]; // Stores a representative number for each prime factor

        int components = uniqueNums.size(); // Each unique number starts as its own component

        for (int x : uniqueNums) {
            int tempX = x;
            while (tempX > 1) {
                int p = smallestPrimeFactor[tempX];

                // If this prime 'p' has not been associated with any component yet,
                // associate it with the current number 'x'.
                if (primeToComponentRoot[p] == 0) {
                    primeToComponentRoot[p] = x;
                } else {
                    // If 'p' has already been associated with a component (via primeToComponentRoot[p]),
                    // it means 'x' and primeToComponentRoot[p] share a common prime factor 'p'.
                    // Therefore, they are NOT coprime (gcd(x, primeToComponentRoot[p]) >= p > 1).
                    // This logic connects numbers that share a common prime factor.
                    // If this union merges two previously distinct components, decrement the count.
                    if (union(x, primeToComponentRoot[p])) {
                        components--;
                    }
                }

                // Remove all occurrences of p from tempX
                while (tempX % p == 0) {
                    tempX /= p;
                }
            }
        }

        return components;
    }
}