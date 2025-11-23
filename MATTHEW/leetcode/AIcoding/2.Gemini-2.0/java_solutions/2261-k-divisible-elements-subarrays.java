import java.util.HashSet;
import java.util.Set;

class Solution {
    public int countDistinct(int[] nums, int k, int p) {
        Set<String> distinctSubarrays = new HashSet<>();
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            int divisibleCount = 0;
            StringBuilder subarrayString = new StringBuilder();
            for (int j = i; j < n; j++) {
                if (nums[j] % p == 0) {
                    divisibleCount++;
                }
                if (divisibleCount > k) {
                    break;
                }
                subarrayString.append(nums[j]).append(",");
                distinctSubarrays.add(subarrayString.toString());
            }
        }

        return distinctSubarrays.size();
    }
}