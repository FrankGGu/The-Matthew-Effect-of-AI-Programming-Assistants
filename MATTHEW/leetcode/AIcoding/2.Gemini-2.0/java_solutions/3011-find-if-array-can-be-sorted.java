class Solution {
    public boolean canSortArray(int[] nums) {
        int n = nums.length;
        int i = 0;
        while (i < n) {
            int j = i;
            int sum = 0;
            while (j < n && Integer.bitCount(nums[i]) == Integer.bitCount(nums[j])) {
                sum += nums[j];
                j++;
            }
            for (int k = i; k < j - 1; k++) {
                if (nums[k] > nums[k + 1]) {

                    int minIndex = k;
                    for(int l = k+1; l < j; l++){
                        if(nums[l] < nums[minIndex]){
                            minIndex = l;
                        }
                    }

                    for(int l = minIndex; l > k; l--){
                        int temp = nums[l];
                        nums[l] = nums[l-1];
                        nums[l-1] = temp;
                    }
                }
            }

            i = j;
        }

        for (int k = 0; k < n - 1; k++) {
            if (nums[k] > nums[k + 1]) {
                return false;
            }
        }
        return true;
    }
}