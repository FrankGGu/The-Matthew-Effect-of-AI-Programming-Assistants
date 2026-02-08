class Solution {
    private int minIncompat;
    private int[] nums;
    private int n;
    private int k;
    private int size;

    public int minimumIncompatibility(int[] nums, int k) {
        this.n = nums.length;
        this.k = k;
        this.size = n / k;
        this.nums = nums;
        this.minIncompat = Integer.MAX_VALUE;

        Arrays.sort(nums);
        backtrack(0, new int[k][size], new int[k], 0);
        return minIncompat == Integer.MAX_VALUE ? -1 : minIncompat;
    }

    private void backtrack(int idx, int[][] groups, int[] groupIndices, int currentIncompat) {
        if (idx == n) {
            minIncompat = Math.min(minIncompat, currentIncompat);
            return;
        }

        for (int i = 0; i < k; i++) {
            if (groupIndices[i] < size) {
                if (groupIndices[i] > 0 && groups[i][groupIndices[i] - 1] == nums[idx]) {
                    continue;
                }
                if (groupIndices[i] == 0 && i > 0 && groupIndices[i - 1] == 0) {
                    continue;
                }

                groups[i][groupIndices[i]] = nums[idx];
                int addedIncompat = 0;
                if (groupIndices[i] == size - 1) {
                    addedIncompat = groups[i][size - 1] - groups[i][0];
                }
                groupIndices[i]++;
                backtrack(idx + 1, groups, groupIndices, currentIncompat + addedIncompat);
                groupIndices[i]--;
            }
        }
    }
}