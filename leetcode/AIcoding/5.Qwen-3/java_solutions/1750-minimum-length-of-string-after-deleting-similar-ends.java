public class Solution {
    public int minimumValue(String s) {
        int left = 0;
        int right = s.length() - 1;

        while (left < right && s.charAt(left) == s.charAt(right)) {
            char c = s.charAt(left);
            while (left <= right && s.charAt(left) == c) {
                left++;
            }
            while (left <= right && s.charAt(right) == c) {
                right--;
            }
        }

        return right - left + 1;
    }
}