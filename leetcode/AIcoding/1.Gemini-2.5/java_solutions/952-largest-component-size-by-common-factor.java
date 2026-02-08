import java.util.HashMap;
import java.util.Map;

class Solution {
    class UnionFind {
        private int[] parent;
        private int[] size;

        public UnionFind(int n) {
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
            return parent[i] = find(parent[i]);
        }

        public void union(int i, int j) {
            int rootI = find(i);
            int rootJ = find(j);
            if (rootI != rootJ) {
                if (size[rootI] < size[rootJ]) {
                    parent[rootI] = rootJ;
                    size[rootJ] += size[rootI];
                } else {
                    parent[rootJ] = rootI;
                    size[rootI] += size[rootJ];
                }
            }
        }
    }

    public int largestComponentSize(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }

        int maxVal = 0;
        for (int num : nums) {
            maxVal = Math.max(maxVal, num);
        }

        UnionFind uf = new UnionFind(maxVal + 1);

        for (int num : nums) {
            if (num == 1) {
                continue;
            }

            int tempNum = num;
            for (int i = 2; i * i <= tempNum; ++i) {
                if (tempNum % i == 0) {
                    uf.union(num, i);
                    while (tempNum % i == 0) {
                        tempNum /= i;
                    }
                }
            }
            if (tempNum > 1) {
                uf.union(num, tempNum);
            }
        }

        Map<Integer, Integer> rootToCount = new HashMap<>();
        int maxComponentSize = 0;

        for (int num : nums) {
            int root = uf.find(num);
            rootToCount.put(root, rootToCount.getOrDefault(root, 0) + 1);
            maxComponentSize = Math.max(maxComponentSize, rootToCount.get(root));
        }

        return maxComponentSize;
    }
}