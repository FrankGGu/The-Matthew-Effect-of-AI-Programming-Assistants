public class Solution {

import java.util.*;

public class Solution {
    public List<String> palindromePairs(int[] nums) {
        List<String> result = new ArrayList<>();
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i != j) {
                    String a = String.valueOf(nums[i]);
                    String b = String.valueOf(nums[j]);
                    String combined = a + b;
                    if (isPalindrome(combined)) {
                        result.add(a + " " + b);
                    }
                }
            }
        }
        return result;
    }

    private boolean isPalindrome(String s) {
        int left = 0;
        int right = s.length() - 1;
        while (left < right) {
            if (s.charAt(left) != s.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
}
}