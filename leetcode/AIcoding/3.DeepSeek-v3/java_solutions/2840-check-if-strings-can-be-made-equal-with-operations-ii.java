class Solution {
    public boolean checkStrings(String s1, String s2) {
        if (s1.length() != s2.length()) {
            return false;
        }
        int[] evenCount1 = new int[26];
        int[] oddCount1 = new int[26];
        int[] evenCount2 = new int[26];
        int[] oddCount2 = new int[26];

        for (int i = 0; i < s1.length(); i++) {
            char c1 = s1.charAt(i);
            char c2 = s2.charAt(i);
            if (i % 2 == 0) {
                evenCount1[c1 - 'a']++;
                evenCount2[c2 - 'a']++;
            } else {
                oddCount1[c1 - 'a']++;
                oddCount2[c2 - 'a']++;
            }
        }

        for (int i = 0; i < 26; i++) {
            if (evenCount1[i] != evenCount2[i] || oddCount1[i] != oddCount2[i]) {
                return false;
            }
        }
        return true;
    }
}