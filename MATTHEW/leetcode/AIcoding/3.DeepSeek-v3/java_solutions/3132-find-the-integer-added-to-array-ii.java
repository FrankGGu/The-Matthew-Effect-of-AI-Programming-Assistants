class Solution {
    public int minimumAddedInteger(int[] nums1, int[] nums2) {
        Arrays.sort(nums1);
        Arrays.sort(nums2);
        int n = nums2.length;
        int minX = Integer.MAX_VALUE;

        for (int i = 0; i <= 2; i++) {
            for (int j = i + 1; j <= 2; j++) {
                int x = nums2[0] - nums1[i];
                boolean valid = true;
                int ptr1 = 0;
                int ptr2 = 0;
                int skip = 0;

                while (ptr2 < n) {
                    if (ptr1 < nums1.length && nums1[ptr1] + x == nums2[ptr2]) {
                        ptr1++;
                        ptr2++;
                    } else {
                        skip++;
                        ptr1++;
                        if (skip > 2) {
                            valid = false;
                            break;
                        }
                    }
                }

                if (valid) {
                    minX = Math.min(minX, x);
                }
            }
        }

        return minX;
    }
}