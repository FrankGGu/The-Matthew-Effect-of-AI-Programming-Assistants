class Solution {
    private class DSU {
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

        public int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        public void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX == rootY) return;
            if (size[rootX] < size[rootY]) {
                parent[rootX] = rootY;
                size[rootY] += size[rootX];
            } else {
                parent[rootY] = rootX;
                size[rootX] += size[rootY];
            }
        }
    }

    public int largestComponentSize(int[] nums) {
        int maxNum = 0;
        for (int num : nums) {
            maxNum = Math.max(maxNum, num);
        }
        DSU dsu = new DSU(maxNum + 1);
        for (int num : nums) {
            for (int i = 2; i <= Math.sqrt(num); i++) {
                if (num % i == 0) {
                    dsu.union(num, i);
                    dsu.union(num, num / i);
                }
            }
        }
        Map<Integer, Integer> map = new HashMap<>();
        int maxSize = 0;
        for (int num : nums) {
            int root = dsu.find(num);
            map.put(root, map.getOrDefault(root, 0) + 1);
            maxSize = Math.max(maxSize, map.get(root));
        }
        return maxSize;
    }
}