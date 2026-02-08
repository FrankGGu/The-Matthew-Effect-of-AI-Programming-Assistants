class Solution {
    public int minimumOperationsToMakeKPeriodic(String word, int k) {
        int n = word.length();
        int numBlocks = n / k;
        int totalOperations = 0;

        for (int j = 0; j < k; j++) {
            int[] charCounts = new int[26];
            int maxFreq = 0;

            for (int i = j; i < n; i += k) {
                char c = word.charAt(i);
                charCounts[c - 'a']++;
                maxFreq = Math.max(maxFreq, charCounts[c - 'a']);
            }

            totalOperations += (numBlocks - maxFreq);
        }

        return totalOperations;
    }
}