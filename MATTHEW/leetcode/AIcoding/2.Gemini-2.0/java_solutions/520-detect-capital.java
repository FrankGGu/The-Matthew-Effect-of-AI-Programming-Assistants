class Solution {
    public boolean detectCapitalUse(String word) {
        int n = word.length();
        if (n == 0) return true;

        boolean firstCapital = Character.isUpperCase(word.charAt(0));
        boolean allCapital = true;
        boolean allLower = true;

        for (int i = 1; i < n; i++) {
            if (!Character.isUpperCase(word.charAt(i))) {
                allCapital = false;
            }
            if (!Character.isLowerCase(word.charAt(i))) {
                allLower = false;
            }
        }

        if (firstCapital) {
            return allCapital || allLower;
        } else {
            return allLower;
        }
    }
}