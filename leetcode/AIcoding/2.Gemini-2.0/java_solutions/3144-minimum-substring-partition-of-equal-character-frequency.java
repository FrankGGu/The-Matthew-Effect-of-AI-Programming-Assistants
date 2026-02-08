class Solution {
    public int maxPartitionsAfterOperations(String s) {
        int n = s.length();
        int distinctChars = 0;
        int[] charCounts = new int[26];
        for (char c : s.toCharArray()) {
            charCounts[c - 'a']++;
        }
        for (int count : charCounts) {
            if (count > 0) {
                distinctChars++;
            }
        }

        if (distinctChars <= 2) {
            return n;
        }

        int maxFreq = 0;
        for (int count : charCounts) {
            maxFreq = Math.max(maxFreq, count);
        }

        if (maxFreq == 1) {
            return 1;
        }

        return Math.max(1, distinctChars - 1);
    }
}