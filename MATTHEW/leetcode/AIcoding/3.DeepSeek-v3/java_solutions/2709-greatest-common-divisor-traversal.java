class Solution {
    private int[] parent;
    private int[] size;

    public boolean canTraverseAllPairs(int[] nums) {
        int maxNum = 0;
        for (int num : nums) {
            maxNum = Math.max(maxNum, num);
        }

        parent = new int[maxNum + 1];
        size = new int[maxNum + 1];
        for (int i = 0; i <= maxNum; i++) {
            parent[i] = i;
            size[i] = 1;
        }

        Set<Integer> uniqueNums = new HashSet<>();
        for (int num : nums) {
            if (num == 1) {
                if (nums.length != 1) {
                    return false;
                } else {
                    return true;
                }
            }
            uniqueNums.add(num);
            int temp = num;
            for (int p = 2; p * p <= temp; p++) {
                if (temp % p == 0) {
                    union(num, p);
                    while (temp % p == 0) {
                        temp /= p;
                    }
                }
            }
            if (temp > 1) {
                union(num, temp);
            }
        }

        Set<Integer> roots = new HashSet<>();
        for (int num : uniqueNums) {
            roots.add(find(num));
        }
        return roots.size() == 1;
    }

    private int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    private void union(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            if (size[rootX] < size[rootY]) {
                parent[rootX] = rootY;
                size[rootY] += size[rootX];
            } else {
                parent[rootY] = rootX;
                size[rootX] += size[rootY];
            }
        }
    }
}