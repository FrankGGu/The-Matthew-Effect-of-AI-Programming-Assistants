import java.util.Arrays;

public class Solution {
    public void wiggleSort(int[] nums) {
        int n = nums.length;
        int[] sortedNums = Arrays.copyOf(nums, n);
        Arrays.sort(sortedNums);

        int mid = (n + 1) / 2;
        int j = n - 1;

        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                nums[i] = sortedNums[mid - 1];
                mid--;
            } else {
                nums[i] = sortedNums[j];
                j--;
            }
        }
    }
}