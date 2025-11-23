class Solution {
    public boolean gcdSort(int[] nums) {
        int n = nums.length;
        int maxVal = 0;
        for (int num : nums) {
            maxVal = Math.max(maxVal, num);
        }

        int[] parent = new int[maxVal + 1];
        for (int i = 0; i <= maxVal; i++) {
            parent[i] = i;
        }

        for (int i = 0; i < n; i++) {
            int num = nums[i];
            for (int j = 2; j * j <= num; j++) {
                if (num % j == 0) {
                    union(parent, num, j);
                    while (num % j == 0) {
                        num /= j;
                    }
                }
            }
            if (num > 1) {
                union(parent, nums[i], num);
            }
        }

        int[] sortedNums = nums.clone();
        java.util.Arrays.sort(sortedNums);

        for (int i = 0; i < n; i++) {
            if (find(parent, nums[i]) != find(parent, sortedNums[i])) {
                return false;
            }
        }

        return true;
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }

    private void union(int[] parent, int i, int j) {
        int rootI = find(parent, i);
        int rootJ = find(parent, j);
        if (rootI != rootJ) {
            parent[rootI] = rootJ;
        }
    }
}