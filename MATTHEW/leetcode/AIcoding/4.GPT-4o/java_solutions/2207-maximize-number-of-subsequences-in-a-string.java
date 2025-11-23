class Solution {
    public long maximumSubsequenceCount(String text, String pattern) {
        long count = 0;
        char a = pattern.charAt(0);
        char b = pattern.charAt(1);

        long aCount = 0;
        long bCount = 0;

        for (char c : text.toCharArray()) {
            if (c == a) {
                aCount++;
            } else if (c == b) {
                bCount++;
            }
        }

        count = Math.max(aCount + bCount, aCount + 1);

        return count;
    }
}