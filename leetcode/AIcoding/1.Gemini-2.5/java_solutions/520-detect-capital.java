class Solution {
    public boolean detectCapitalUse(String word) {
        int n = word.length();
        if (n == 0) {
            return true;
        }

        int capitalCount = 0;
        for (int i = 0; i < n; i++) {
            if (Character.isUpperCase(word.charAt(i))) {
                capitalCount++;
            }
        }

        if (capitalCount == 0) { // All lowercase, e.g., "leetcode"
            return true;
        }
        if (capitalCount == n) { // All uppercase, e.g., "USA"
            return true;
        }
        if (capitalCount == 1 && Character.isUpperCase(word.charAt(0))) { // Only first letter capital, e.g., "Google"
            return true;
        }

        return false;
    }
}