public class Solution {

import java.util.*;

public class Solution {
    public int kMirror(int k, int n) {
        int count = 0;
        int num = 1;
        while (count < n) {
            if (isPalindrome(num) && isKMirror(num, k)) {
                count++;
            }
            num++;
        }
        return num - 1;
    }

    private boolean isPalindrome(int num) {
        String s = Integer.toString(num);
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

    private boolean isKMirror(int num, int k) {
        String s = Integer.toString(num, k);
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