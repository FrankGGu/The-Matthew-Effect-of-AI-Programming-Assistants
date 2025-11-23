class Solution {
    public int countVowelSubstrings(String s, int k) {
        int n = s.length(), count = 0;
        for (int i = 0; i < n; i++) {
            int[] freq = new int[26];
            int vowels = 0, consonants = 0;
            for (int j = i; j < n; j++) {
                char c = s.charAt(j);
                if (isVowel(c)) {
                    if (freq[c - 'a'] == 0) vowels++;
                    freq[c - 'a']++;
                } else {
                    consonants++;
                    freq[c - 'a']++;
                }
                if (vowels == 5 && consonants >= k) count++;
            }
        }
        return count;
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
}