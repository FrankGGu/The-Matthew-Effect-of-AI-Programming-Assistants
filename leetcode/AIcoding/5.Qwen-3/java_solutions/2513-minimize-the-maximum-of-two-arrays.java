public class Solution {

import java.util.*;

public class Solution {
    public int minimizeMax(int[] nums, int x) {
        Arrays.sort(nums);
        int n = nums.length;
        int left = 0, right = nums[n - 1] - nums[0];
        int result = right;

        while (left <= right) {
            int mid = (left + right) / 2;
            int count = 0;
            int i = 0;
            while (i < n) {
                int j = i;
                while (j < n && nums[j] - nums[i] <= mid) {
                    j++;
                }
                count++;
                i = j;
            }
            if (count <= x) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return result;
    }
}
}