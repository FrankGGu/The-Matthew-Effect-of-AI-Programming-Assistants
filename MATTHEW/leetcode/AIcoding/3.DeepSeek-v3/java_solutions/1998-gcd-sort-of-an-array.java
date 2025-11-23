class UnionFind {
    private int[] parent;
    private int[] rank;

    public UnionFind(int size) {
        parent = new int[size];
        rank = new int[size];
        for (int i = 0; i < size; i++) {
            parent[i] = i;
            rank[i] = 1;
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
            if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else if (rank[rootX] < rank[rootY]) {
                parent[rootX] = rootY;
            } else {
                parent[rootY] = rootX;
                rank[rootX]++;
            }
        }
    }
}

class Solution {
    public boolean gcdSort(int[] nums) {
        int maxNum = 0;
        for (int num : nums) {
            maxNum = Math.max(maxNum, num);
        }
        UnionFind uf = new UnionFind(maxNum + 1);
        boolean[] present = new boolean[maxNum + 1];
        for (int num : nums) {
            present[num] = true;
        }
        for (int i = 2; i <= maxNum; i++) {
            if (!present[i]) continue;
            for (int j = 2 * i; j <= maxNum; j += i) {
                if (present[j]) {
                    uf.union(i, j);
                }
            }
        }
        int[] sorted = nums.clone();
        Arrays.sort(sorted);
        for (int i = 0; i < nums.length; i++) {
            if (uf.find(nums[i]) != uf.find(sorted[i])) {
                return false;
            }
        }
        return true;
    }
}