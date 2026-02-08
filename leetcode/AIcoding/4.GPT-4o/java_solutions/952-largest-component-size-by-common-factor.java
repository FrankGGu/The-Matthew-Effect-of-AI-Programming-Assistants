import java.util.*;

class Solution {
    public int largestComponentSize(int[] A) {
        int max = Arrays.stream(A).max().getAsInt();
        UnionFind uf = new UnionFind(max + 1);

        for (int num : A) {
            for (int factor = 2; factor * factor <= num; factor++) {
                if (num % factor == 0) {
                    uf.union(num, factor);
                    uf.union(num, num / factor);
                }
            }
        }

        Map<Integer, Integer> count = new HashMap<>();
        int maxSize = 0;

        for (int num : A) {
            int root = uf.find(num);
            count.put(root, count.getOrDefault(root, 0) + 1);
            maxSize = Math.max(maxSize, count.get(root));
        }

        return maxSize;
    }

    class UnionFind {
        int[] parent;

        UnionFind(int size) {
            parent = new int[size];
            for (int i = 0; i < size; i++) {
                parent[i] = i;
            }
        }

        int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootY] = rootX;
            }
        }
    }
}