import java.util.Arrays;

class Solution {
    public int maximumElementAfterDecrementingAndRearranging(int[] arr) {
        Arrays.sort(arr);

        int ans = 0; 

        for (int num : arr) {
            ans = Math.min(num, ans + 1);
        }

        return ans;
    }
}