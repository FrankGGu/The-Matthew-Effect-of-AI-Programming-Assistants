class Solution {
    public int[] lexicographicallySmallestArray(int[] nums, int limit) {
        int n = nums.length;
        int[][] indexedNums = new int[n][2];
        for (int i = 0; i < n; i++) {
            indexedNums[i][0] = nums[i];
            indexedNums[i][1] = i;
        }
        Arrays.sort(indexedNums, (a, b) -> a[0] - b[0]);

        List<List<int[]>> groups = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (i == 0 || indexedNums[i][0] - indexedNums[i - 1][0] > limit) {
                groups.add(new ArrayList<>());
            }
            groups.get(groups.size() - 1).add(indexedNums[i]);
        }

        int[] result = new int[n];
        for (List<int[]> group : groups) {
            List<Integer> indices = new ArrayList<>();
            for (int[] num : group) {
                indices.add(num[1]);
            }
            Collections.sort(indices);
            for (int i = 0; i < group.size(); i++) {
                result[indices.get(i)] = group.get(i)[0];
            }
        }
        return result;
    }
}