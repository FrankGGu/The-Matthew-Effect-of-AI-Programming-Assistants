public class Solution {
    public int numOfSubarrays(int[] arr) {
        int n = arr.length;
        int odd = 0, even = 0;
        int result = 0;
        for (int i = 0; i < n; i++) {
            if (arr[i] % 2 == 1) {
                int temp = odd;
                odd = even + 1;
                even = temp;
            } else {
                odd = odd;
                even = even + 1;
            }
            result = (result + odd) % (10^9 + 7);
        }
        return result;
    }
}