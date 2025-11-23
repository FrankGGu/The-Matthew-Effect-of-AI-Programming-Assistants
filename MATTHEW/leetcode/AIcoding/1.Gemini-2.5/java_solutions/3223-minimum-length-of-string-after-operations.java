class Solution {
    public int minimumLength(String s) {
        int left = 0;
        int right = s.length() - 1;

        while (left < right && s.charAt(left) == s.charAt(right)) {
            char charToRemove = s.charAt(left);

            // Remove all occurrences of charToRemove from the prefix
            // The loop continues as long as left pointer is within bounds and character matches.
            // It's important to use left <= right here to consume all identical characters
            // even if left eventually crosses right.
            while (left <= right && s.charAt(left) == charToRemove) {
                left++;
            }

            // Remove all occurrences of charToRemove from the suffix
            // The loop continues as long as right pointer is within bounds and character matches.
            // It's important to use left <= right here to consume all identical characters
            // even if right eventually crosses left.
            while (left <= right && s.charAt(right) == charToRemove) {
                right--;
            }
        }

        // After the loop, if left > right, it means the entire string was removed.
        // If left <= right, it means the remaining substring s[left...right] cannot be further reduced.
        // The length of the remaining string is right - left + 1.
        // Math.max(0, ...) handles cases where left > right (resulting in a negative length), returning 0.
        return Math.max(0, right - left + 1);
    }
}