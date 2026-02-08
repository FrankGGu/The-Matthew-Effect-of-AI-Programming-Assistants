class Solution {
    public int minOperations(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int last1 = nums1[n - 1];
        int last2 = nums2[n - 1];

        int count1 = 0;
        int count2 = 0;

        int tempLast1 = nums1[n - 1];
        int tempLast2 = nums2[n - 1];

        for (int i = 0; i < n; i++) {
            if (nums1[i] > last1 && nums2[i] > last1) {
                return -1;
            }
            if (nums1[i] > last1) {
                count1++;
            }
            if (nums2[i] > last1) {

            }
        }

        for (int i = 0; i < n; i++) {
            if (nums1[i] > last2 && nums2[i] > last2) {
                return -1;
            }
            if (nums1[i] > last2) {

            }
            if (nums2[i] > last2) {
                count2++;
            }
        }

        int count1_swap = 0;
        int count2_swap = 0;
        for (int i = 0; i < n - 1; i++) {
            if (nums1[i] > last1) {
                count1_swap++;
            }
        }
        for (int i = 0; i < n - 1; i++) {
            if (nums1[i] > last2) {
                count2_swap++;
            }
        }

        int count1_swap2 = 0;
        int count2_swap2 = 0;

        for (int i = 0; i < n - 1; i++) {
            if (nums2[i] > last1) {
                count1_swap2++;
            }
        }
        for (int i = 0; i < n - 1; i++) {
            if (nums2[i] > last2) {
                count2_swap2++;
            }
        }

        int ans = Integer.MAX_VALUE;

        boolean possible1 = true;
        for(int i = 0; i < n; i++){
            if(nums1[i] > last1 && nums2[i] > last1)
                possible1 = false;
        }

        if(possible1){
            int cur = 0;
            for(int i = 0; i < n; i++){
                if(nums1[i] > last1) cur++;
            }
            ans = Math.min(ans, cur);
        }

        boolean possible2 = true;
        for(int i = 0; i < n; i++){
            if(nums1[i] > last2 && nums2[i] > last2)
                possible2 = false;
        }

        if(possible2){
            int cur = 0;
            for(int i = 0; i < n; i++){
                if(nums1[i] > last2) cur++;
            }
            ans = Math.min(ans, cur + 1);
        }

        if(ans == Integer.MAX_VALUE) return -1;

        return ans;
    }
}