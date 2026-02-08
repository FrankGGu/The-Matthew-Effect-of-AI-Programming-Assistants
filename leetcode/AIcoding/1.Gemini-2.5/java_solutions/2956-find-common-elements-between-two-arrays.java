class Solution {
    public int[] findCommonElements(int[] nums1, int[] nums2) {
        boolean[] presentInNums1 = new boolean[1001];
        boolean[] presentInNums2 = new boolean[1001];

        for (int num : nums1) {
            presentInNums1[num] = true;
        }

        for (int num : nums2) {
            presentInNums2[num] = true;
        }

        int answer1 = 0;
        for (int num : nums1) {
            if (presentInNums2[num]) {
                answer1++;
            }
        }

        int answer2 = 0;
        for (int num : nums2) {
            if (presentInNums1[num]) {
                answer2++;
            }
        }

        return new int[]{answer1, answer2};
    }
}