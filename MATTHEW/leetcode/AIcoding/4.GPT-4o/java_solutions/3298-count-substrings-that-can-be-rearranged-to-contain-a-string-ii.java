class Solution {
    public int countSubstrings(String s, String t) {
        int count = 0;
        int n = s.length(), m = t.length();
        for (int i = 0; i < n; i++) {
            int[] sCount = new int[26];
            for (int j = i; j < n; j++) {
                sCount[s.charAt(j) - 'a']++;
                if (j - i + 1 < m) continue;
                if (j - i + 1 > m) {
                    count++;
                    continue;
                }
                int[] tCount = new int[26];
                for (char c : t.toCharArray()) {
                    tCount[c - 'a']++;
                }
                int diff = 0;
                for (int k = 0; k < 26; k++) {
                    if (sCount[k] < tCount[k]) {
                        diff += tCount[k] - sCount[k];
                    }
                }
                if (diff == 0) count++;
            }
        }
        return count;
    }
}