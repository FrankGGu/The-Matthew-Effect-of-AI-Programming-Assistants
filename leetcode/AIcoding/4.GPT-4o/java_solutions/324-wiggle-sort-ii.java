import java.util.Arrays;

public class Solution {
    public void wiggleSort(int[] nums) {
        int n = nums.length;
        int[] copy = nums.clone();
        Arrays.sort(copy);

        int mid = (n - 1) / 2;
        int j = mid;
        int k = n - 1;

        for (int i = 0; i < n; i++) {
            nums[i] = (i % 2 == 0) ? copy[j--] : copy[k--];
        }
    }
}