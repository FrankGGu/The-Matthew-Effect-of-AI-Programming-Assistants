import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public int countDistinct(int[] nums, int k, int p) {
        Set<List<Integer>> distinctSubarrays = new HashSet<>();
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            int divisibleCount = 0;
            List<Integer> currentSubarray = new ArrayList<>();
            for (int j = i; j < n; j++) {
                if (nums[j] % p == 0) {
                    divisibleCount++;
                }

                if (divisibleCount > k) {
                    break;
                }

                currentSubarray.add(nums[j]);
                distinctSubarrays.add(new ArrayList<>(currentSubarray));
            }
        }

        return distinctSubarrays.size();
    }
}