public class Solution {
    public int minSwap(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int[] swap = new int[n];
        int[] notSwap = new int[n];
        swap[0] = 1;
        notSwap[0] = 0;

        for (int i = 1; i < n; i++) {
            if (nums1[i] > nums1[i - 1] && nums2[i] > nums2[i - 1]) {
                swap[i] = swap[i - 1] + 1;
                notSwap[i] = notSwap[i - 1];
            } else if (nums1[i] > nums2[i - 1] && nums2[i] > nums1[i - 1]) {
                swap[i] = Math.min(swap[i - 1], notSwap[i - 1]) + 1;
                notSwap[i] = Math.min(swap[i - 1], notSwap[i - 1]);
            } else {
                if (nums1[i] > nums1[i - 1]) {
                    swap[i] = swap[i - 1] + 1;
                    notSwap[i] = notSwap[i - 1];
                } else {
                    swap[i] = notSwap[i - 1] + 1;
                    notSwap[i] = swap[i - 1];
                }
            }
        }
        return Math.min(swap[n - 1], notSwap[n - 1]);
    }
}