import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;

class Solution {
    public int minOperations(int[] nums) {
        int n = nums.length;

        Arrays.sort(nums);

        List<Integer> uniqueNumsList = new ArrayList<>();
        if (n > 0) {
            uniqueNumsList.add(nums[0]);
            for (int i = 1; i < n; i++) {
                if (nums[i] != nums[i-1]) {
                    uniqueNumsList.add(nums[i]);
                }
            }
        }

        int minOps = n;
        int right = 0;

        for (int left = 0; left < uniqueNumsList.size(); left++) {
            // For each uniqueNumsList.get(left) as a potential starting element of the continuous array,
            // the target range would be [uniqueNumsList.get(left), uniqueNumsList.get(left) + n - 1].
            // We count how many elements from uniqueNumsList fall into this target range.
            // An element x is in range if x <= uniqueNumsList.get(left) + n - 1,
            // which is equivalent to x < uniqueNumsList.get(left) + n.
            while (right < uniqueNumsList.size() && uniqueNumsList.get(right) < uniqueNumsList.get(left) + n) {
                right++;
            }

            // 'count' represents the number of unique elements from the original array
            // that are already within our chosen target continuous range.
            int count = right - left;

            // To make the array continuous, we need 'n' unique elements.
            // We already have 'count' elements that fit.
            // Therefore, 'n - count' elements need to be changed/introduced.
            minOps = Math.min(minOps, n - count);
        }

        return minOps;
    }
}