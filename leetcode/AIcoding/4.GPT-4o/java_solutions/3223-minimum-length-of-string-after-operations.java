class Solution {
    public int minimumLength(String s) {
        int left = 0, right = s.length() - 1;
        while (left < right) {
            if (s.charAt(left) == s.charAt(right)) {
                char c = s.charAt(left);
                while (left <= right && s.charAt(left) == c) left++;
                while (left <= right && s.charAt(right) == c) right--;
            } else {
                break;
            }
        }
        return right - left + 1;
    }
}