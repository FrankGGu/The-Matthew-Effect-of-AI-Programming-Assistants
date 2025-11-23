class Solution {
    public String repeatLimitedString(String s, int repeatLimit) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }

        StringBuilder sb = new StringBuilder();

        for (int i = 25; i >= 0; i--) { // Iterate from 'z' down to 'a'
            while (freq[i] > 0) {
                // Append current character 'i' up to repeatLimit times
                int count = Math.min(freq[i], repeatLimit);
                for (int k = 0; k < count; k++) {
                    sb.append((char) ('a' + i));
                }
                freq[i] -= count;

                // If we still have character 'i' left (meaning we hit repeatLimit)
                if (freq[i] > 0) {
                    // Find the next largest character 'j' (smaller than 'i')
                    // that we can append once to break the sequence
                    int j = i - 1;
                    while (j >= 0 && freq[j] == 0) {
                        j--;
                    }

                    // If no such character 'j' is found, we cannot append 'i' anymore
                    // because there's no smaller character to break the sequence.
                    // Also, since we iterate 'i' downwards, no other characters can be added.
                    if (j < 0) {
                        i = -1; // Set 'i' to -1 to break the outer loop as well
                        break;  // Break the inner while loop for current 'i'
                    } else {
                        // Append character 'j' once
                        sb.append((char) ('a' + j));
                        freq[j]--;
                        // Now we can try to append character 'i' again in the next iteration
                        // of the while loop, as the sequence is broken by 'j'.
                    }
                }
            }
        }

        return sb.toString();
    }
}