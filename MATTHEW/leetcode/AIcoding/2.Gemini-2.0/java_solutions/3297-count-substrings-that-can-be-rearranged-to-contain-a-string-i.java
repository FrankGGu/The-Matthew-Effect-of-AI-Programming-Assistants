class Solution {
    public int countSubstrings(String s, String t) {
        int n = s.length();
        int m = t.length();
        int count = 0;

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                String sub = s.substring(i, j + 1);
                if (canRearrange(sub, t)) {
                    count++;
                }
            }
        }

        return count;
    }

    private boolean canRearrange(String s, String t) {
        int[] sFreq = new int[26];
        int[] tFreq = new int[26];

        for (char c : s.toCharArray()) {
            sFreq[c - 'a']++;
        }

        for (char c : t.toCharArray()) {
            tFreq[c - 'a']++;
        }

        for (int i = 0; i < 26; i++) {
            if (tFreq[i] > 0 && sFreq[i] < tFreq[i]) {
                return false;
            }
        }

        return true;
    }
}