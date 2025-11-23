import java.util.Arrays;

class Solution {
    public int[] numSmallerByFrequency(String[] queries, String[] words) {
        int[] wordFrequencies = new int[words.length];
        for (int i = 0; i < words.length; i++) {
            wordFrequencies[i] = calculateFrequency(words[i]);
        }
        Arrays.sort(wordFrequencies);

        int[] results = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int queryFreq = calculateFrequency(queries[i]);

            int low = 0, high = wordFrequencies.length - 1;
            int firstGreaterIndex = wordFrequencies.length; 

            while (low <= high) {
                int mid = low + (high - low) / 2;
                if (wordFrequencies[mid] > queryFreq) {
                    firstGreaterIndex = mid;
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            }
            results[i] = wordFrequencies.length - firstGreaterIndex;
        }
        return results;
    }

    private int calculateFrequency(String s) {
        char smallestChar = s.charAt(0);
        int count = 1;

        for (int i = 1; i < s.length(); i++) {
            char currentChar = s.charAt(i);
            if (currentChar < smallestChar) {
                smallestChar = currentChar;
                count = 1;
            } else if (currentChar == smallestChar) {
                count++;
            }
        }
        return count;
    }
}