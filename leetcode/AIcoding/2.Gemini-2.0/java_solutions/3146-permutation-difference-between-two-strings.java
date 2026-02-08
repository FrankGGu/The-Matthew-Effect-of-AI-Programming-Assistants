class Solution {
    public int permutationDifference(String s1, String s2) {
        int n1 = s1.length();
        int n2 = s2.length();
        if (n1 != n2) {
            return -1;
        }

        int[] freq1 = new int[26];
        int[] freq2 = new int[26];

        for (int i = 0; i < n1; i++) {
            freq1[s1.charAt(i) - 'a']++;
            freq2[s2.charAt(i) - 'a']++;
        }

        for (int i = 0; i < 26; i++) {
            if (freq1[i] != freq2[i]) {
                return -1;
            }
        }

        int diff = 0;
        for (int i = 0; i < n1; i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                diff++;
            }
        }

        return diff;
    }
}