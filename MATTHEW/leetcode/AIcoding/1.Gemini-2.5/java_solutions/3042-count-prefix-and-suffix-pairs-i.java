class Solution {
    public int countPrefixSuffixPairs(String[] words) {
        int count = 0;
        int n = words.length;

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                String s1 = words[i];
                String s2 = words[j];

                // Check if s1 is a prefix of s2
                // Check if s1 is a suffix of s2
                if (s2.startsWith(s1) && s2.endsWith(s1)) {
                    count++;
                }
            }
        }

        return count;
    }
}