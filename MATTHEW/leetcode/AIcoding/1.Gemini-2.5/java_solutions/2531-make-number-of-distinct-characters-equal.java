class Solution {
    public boolean equalDistinctCharacters(String word1, String word2) {
        int[] count1 = new int[26];
        int[] count2 = new int[26];

        for (char c : word1.toCharArray()) {
            count1[c - 'a']++;
        }
        for (char c : word2.toCharArray()) {
            count2[c - 'a']++;
        }

        for (int i = 0; i < 26; i++) { // Character to potentially take from word1
            for (int j = 0; j < 26; j++) { // Character to potentially take from word2
                // If character 'a'+i is not present in word1, we cannot take it.
                if (count1[i] == 0) {
                    continue;
                }
                // If character 'a'+j is not present in word2, we cannot take it.
                if (count2[j] == 0) {
                    continue;
                }

                // Simulate the swap:
                // Take character 'a'+i from word1, give 'a'+j to word1
                count1[i]--;
                count1[j]++;
                // Take character 'a'+j from word2, give 'a'+i to word2
                count2[j]--;
                count2[i]++;

                // Calculate distinct characters after the simulated swap
                int distinct1 = 0;
                for (int k = 0; k < 26; k++) {
                    if (count1[k] > 0) {
                        distinct1++;
                    }
                }

                int distinct2 = 0;
                for (int k = 0; k < 26; k++) {
                    if (count2[k] > 0) {
                        distinct2++;
                    }
                }

                // If distinct counts are equal, we found a valid swap
                if (distinct1 == distinct2) {
                    return true;
                }

                // Revert the swap for the next iteration
                count1[i]++;
                count1[j]--;
                count2[j]++;
                count2[i]--;
            }
        }

        // No swap resulted in equal distinct character counts
        return false;
    }
}