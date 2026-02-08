import java.util.Arrays;

class Solution {
    public void wiggleSort(int[] nums) {
        int n = nums.length;

        int[] temp = Arrays.copyOf(nums, n);
        Arrays.sort(temp);

        int smallHalfEndIdx = (n - 1) / 2;
        int largeHalfEndIdx = n - 1;

        int smallPtr = smallHalfEndIdx;
        int largePtr = largeHalfEndIdx;

        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                nums[i] = temp[smallPtr];
                smallPtr--;
            } else {
                nums[i] = temp[largePtr];
                largePtr--;
            }
        }
    }
}