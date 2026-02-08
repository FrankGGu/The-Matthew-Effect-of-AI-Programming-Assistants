public class Solution {

import java.util.*;

public class Solution {
    public boolean canDivideArray(int[] nums) {
        int n = nums.length;
        if (n % 2 != 0) return false;

        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        UnionFind uf = new UnionFind(10001);

        for (int num : nums) {
            for (int i = 2; i * i <= num; i++) {
                if (num % i == 0) {
                    uf.union(num, i);
                    uf.union(num, num / i);
                }
            }
        }

        for (int num : nums) {
            int root = uf.find(num);
            if (freq.get(root) % 2 != 0) {
                return false;
            }
        }

        return true;
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