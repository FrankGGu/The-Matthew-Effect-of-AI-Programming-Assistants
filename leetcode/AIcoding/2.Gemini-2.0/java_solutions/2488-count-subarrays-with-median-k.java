class Solution {
    public int countSubarrays(int[] nums, int k) {
        int n = nums.length;
        int kIndex = -1;
        for (int i = 0; i < n; i++) {
            if (nums[i] == k) {
                kIndex = i;
                break;
            }
        }

        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                int len = j - i + 1;
                int[] subarray = new int[len];
                for (int l = i; l <= j; l++) {
                    subarray[l - i] = nums[l];
                }

                boolean containsK = false;
                for(int val : subarray){
                    if(val == k){
                        containsK = true;
                        break;
                    }
                }

                if(!containsK){
                    continue;
                }

                int greater = 0;
                int equal = 0;
                int smaller = 0;
                for (int val : subarray) {
                    if (val > k) {
                        greater++;
                    } else if (val == k) {
                        equal++;
                    } else {
                        smaller++;
                    }
                }

                if (greater == smaller) {
                    count++;
                }
            }
        }

        return count;
    }
}