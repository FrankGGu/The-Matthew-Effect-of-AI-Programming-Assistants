import java.util.HashSet;
import java.util.Set;

class Solution {
    public int countCompleteSubarrays(int[] nums) {
        Set<Integer> distinctNums = new HashSet<>();
        for (int num : nums) {
            distinctNums.add(num);
        }
        int k = distinctNums.size();
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            Set<Integer> currentSet = new HashSet<>();
            for (int j = i; j < nums.length; j++) {
                currentSet.add(nums[j]);
                if (currentSet.size() == k) {
                    count++;
                }
            }
        }
        return count;
    }
}