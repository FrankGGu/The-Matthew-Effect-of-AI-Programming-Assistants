import java.util.Arrays;

class Solution {
    public int maxDistinctElements(int[] nums, int k) {
        Arrays.sort(nums);
        int n = nums.length;
        int distinct = 0;
        int i = 0;
        while (i < n) {
            int j = i;
            while (j < n && nums[i] == nums[j]) {
                j++;
            }
            int count = j - i;
            if (count > 1) {
                int need = count - 1;
                if (k >= need) {
                    k -= need;
                } else {
                    distinct++;
                }
            } else {
                distinct++;
            }
            i = j;
        }

        int same = n - distinct;

        if(k >= same){
            distinct += same;
            k -= same;
            distinct = Math.min(distinct, n);
            distinct = distinct - Math.min(distinct, k);

            return distinct;
        } else {
            return distinct + k;
        }
    }
}