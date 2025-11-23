public class Solution {

import java.util.*;

public class Solution {
    public int[] numSmallerByFrequency(final String[] queries, final String[] words) {
        int[] wordFreq = new int[words.length];
        for (int i = 0; i < words.length; i++) {
            wordFreq[i] = countSmallestChar(words[i]);
        }
        Arrays.sort(wordFreq);
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int qFreq = countSmallestChar(queries[i]);
            int left = 0, right = wordFreq.length;
            while (left < right) {
                int mid = (left + right) / 2;
                if (wordFreq[mid] > qFreq) {
                    right = mid;
                } else {
                    left = mid + 1;
                }
            }
            result[i] = wordFreq.length - left;
        }
        return result;
    }

    private int countSmallestChar(String s) {
        char minChar = s.charAt(0);
        int count = 1;
        for (int i = 1; i < s.length(); i++) {
            if (s.charAt(i) < minChar) {
                minChar = s.charAt(i);
                count = 1;
            } else if (s.charAt(i) == minChar) {
                count++;
            }
        }
        return count;
    }
}
}