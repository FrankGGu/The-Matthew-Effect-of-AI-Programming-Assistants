class Solution {
    public int minimumLength(String s) {
        int left = 0;
        int right = s.length() - 1;

        while (left < right && s.charAt(left) == s.charAt(right)) {
            char commonChar = s.charAt(left);

            while (left <= right && s.charAt(left) == commonChar) {
                left++;
            }

            while (left <= right && s.charAt(right) == commonChar) {
                right--;
            }
        }

        return Math.max(0, right - left + 1);
    }
}