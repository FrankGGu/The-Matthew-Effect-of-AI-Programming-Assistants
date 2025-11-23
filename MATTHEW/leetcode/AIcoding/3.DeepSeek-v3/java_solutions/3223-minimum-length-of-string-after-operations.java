class Solution {
    public int minimumLength(String s) {
        int left = 0, right = s.length() - 1;
        while (left < right && s.charAt(left) == s.charAt(right)) {
            char current = s.charAt(left);
            while (left <= right && s.charAt(left) == current) {
                left++;
            }
            while (left <= right && s.charAt(right) == current) {
                right--;
            }
        }
        return right - left + 1;
    }
}