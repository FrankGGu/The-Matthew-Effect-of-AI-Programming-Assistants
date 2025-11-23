import java.util.Arrays;

class Solution {
    public int[] numSmallerByFrequency(String[] queries, String[] words) {
        int[] queryCounts = new int[queries.length];
        int[] wordCounts = new int[words.length];

        for (int i = 0; i < queries.length; i++) {
            queryCounts[i] = f(queries[i]);
        }

        for (int i = 0; i < words.length; i++) {
            wordCounts[i] = f(words[i]);
        }

        Arrays.sort(wordCounts);
        int[] result = new int[queries.length];

        for (int i = 0; i < queryCounts.length; i++) {
            int left = 0, right = wordCounts.length;
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (wordCounts[mid] > queryCounts[i]) {
                    right = mid;
                } else {
                    left = mid + 1;
                }
            }
            result[i] = wordCounts.length - left;
        }

        return result;
    }

    private int f(String s) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        for (int i = 0; i < 26; i++) {
            if (count[i] > 0) {
                return count[i];
            }
        }
        return 0;
    }
}