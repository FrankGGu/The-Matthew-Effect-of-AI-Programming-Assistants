class Solution {
    public boolean areOccurrencesEqual(String s) {
        int[] counts = new int[26];
        for (char c : s.toCharArray()) {
            counts[c - 'a']++;
        }

        int expectedCount = 0;
        for (int count : counts) {
            if (count > 0) {
                if (expectedCount == 0) {
                    expectedCount = count;
                } else if (count != expectedCount) {
                    return false;
                }
            }
        }
        return true;
    }
}