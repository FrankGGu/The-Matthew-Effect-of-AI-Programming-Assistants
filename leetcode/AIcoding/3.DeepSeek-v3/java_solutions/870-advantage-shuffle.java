class Solution {
    public int[] advantageCount(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int[][] indexedNums2 = new int[n][2];
        for (int i = 0; i < n; i++) {
            indexedNums2[i][0] = nums2[i];
            indexedNums2[i][1] = i;
        }
        Arrays.sort(indexedNums2, (a, b) -> a[0] - b[0]);
        Arrays.sort(nums1);
        int[] res = new int[n];
        int left = 0, right = n - 1;
        for (int i = n - 1; i >= 0; i--) {
            int val = indexedNums2[i][0];
            int index = indexedNums2[i][1];
            if (nums1[right] > val) {
                res[index] = nums1[right];
                right--;
            } else {
                res[index] = nums1[left];
                left++;
            }
        }
        return res;
    }
}