import java.util.*;

public class Solution {
    public long kMirror(int k, int n) {
        long sum = 0;
        int count = 0;
        int num = 1;

        while (count < n) {
            if (isPalindrome(num) && isKPalindrome(num, k)) {
                sum += num;
                count++;
            }
            num++;
        }

        return sum;
    }

    private boolean isPalindrome(int num) {
        String str = Integer.toString(num);
        int left = 0, right = str.length() - 1;
        while (left < right) {
            if (str.charAt(left) != str.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    private boolean isKPalindrome(int num, int k) {
        StringBuilder sb = new StringBuilder();
        while (num > 0) {
            sb.append(num % k);
            num /= k;
        }
        String kRepresentation = sb.reverse().toString();
        return isPalindrome(Integer.parseInt(kRepresentation));
    }
}