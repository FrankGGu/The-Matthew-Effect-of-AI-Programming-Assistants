public class Solution {
    public boolean checkValidString(String s) {
        int left = 0, right = 0;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '(') {
                left++;
                right++;
            } else if (c == ')') {
                left--;
                right--;
            } else {
                left++;
                right--;
            }
            if (right < 0) return false;
            left = Math.max(left, 0);
        }
        return left == 0;
    }
}