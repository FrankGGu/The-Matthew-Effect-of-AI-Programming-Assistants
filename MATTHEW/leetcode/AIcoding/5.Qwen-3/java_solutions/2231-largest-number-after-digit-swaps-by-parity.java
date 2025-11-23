public class Solution {

import java.util.Arrays;

public class Solution {
    public String largestNumber(int[] nums) {
        int n = nums.length;
        Integer[] arr = new Integer[n];
        for (int i = 0; i < n; i++) {
            arr[i] = nums[i];
        }
        Arrays.sort(arr, (a, b) -> {
            if (a % 2 == b % 2) {
                return b - a;
            } else {
                return a % 2 == 0 ? -1 : 1;
            }
        });
        StringBuilder sb = new StringBuilder();
        for (int num : arr) {
            sb.append(num);
        }
        while (sb.length() > 0 && sb.charAt(0) == '0') {
            sb.deleteCharAt(0);
        }
        return sb.length() == 0 ? "0" : sb.toString();
    }
}
}