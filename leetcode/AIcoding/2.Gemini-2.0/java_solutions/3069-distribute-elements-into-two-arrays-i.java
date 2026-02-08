class Solution {
    public int[] distributeElements(int[] nums, int[] moveFrom) {
        int n = nums.length;
        int m = moveFrom.length;
        int[] arr1 = new int[n];
        int[] arr2 = new int[n];
        int idx1 = 0;
        int idx2 = 0;

        for (int i = 0; i < m; i++) {
            if (nums[moveFrom[i]] % 2 == 0) {
                arr1[idx1++] = nums[moveFrom[i]];
            } else {
                arr2[idx2++] = nums[moveFrom[i]];
            }
        }

        int[] ans = new int[n];
        int idx = 0;
        for (int i = 0; i < idx1; i++) {
            ans[idx++] = arr1[i];
        }
        for (int i = 0; i < idx2; i++) {
            ans[idx++] = arr2[i];
        }

        return ans;
    }
}