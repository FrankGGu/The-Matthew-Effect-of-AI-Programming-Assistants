class Solution {
    public long countCompleteSubstrings(String s, int k) {
        int n = s.length();
        long completeSubstringsCount = 0;

        for (int i = 0; i < n; i++) {
            int[] freq = new int[26]; // Frequency array for characters 'a' through 'z'

            for (int j = i; j < n; j++) {
                char currentChar = s.charAt(j);
                freq[currentChar - 'a']++; // Increment frequency of the current character

                // Variables to check the two conditions for a complete substring
                boolean allPresentSameFreq = true;
                int firstPresentFreq = -1; // Stores the frequency of the first distinct character encountered

                int maxOverallFreq = 0; // Maximum frequency among all 26 characters ('a' through 'z')
                int minOverallFreq = Integer.MAX_VALUE; // Minimum frequency among all 26 characters ('a' through 'z')

                // Iterate through all 26 possible characters to check conditions
                for (int charIdx = 0; charIdx < 26; charIdx++) {
                    int currentFreq = freq[charIdx];

                    // Update maxOverallFreq and minOverallFreq for Condition 2
                    maxOverallFreq = Math.max(maxOverallFreq, currentFreq);
                    minOverallFreq = Math.min(minOverallFreq, currentFreq);

                    // Check Condition 1: All characters present in the substring must have the same frequency
                    if (currentFreq > 0) {
                        if (firstPresentFreq == -1) {
                            // This is the first distinct character found with a positive frequency
                            firstPresentFreq = currentFreq;
                        } else if (firstPresentFreq != currentFreq) {
                            // Found another distinct character with a different frequency
                            allPresentSameFreq = false;
                            break; // Condition 1 failed, no need to check further for this substring
                        }
                    }
                }

                // If Condition 1 is met (all present characters have the same frequency)
                // AND Condition 2 is met (max_freq - min_freq <= k)
                if (allPresentSameFreq && (maxOverallFreq - minOverallFreq <= k)) {
                    completeSubstringsCount++;
                }
            }
        }
        return completeSubstringsCount;
    }
}