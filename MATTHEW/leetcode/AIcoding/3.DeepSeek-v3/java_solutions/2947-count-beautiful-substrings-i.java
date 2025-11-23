class Solution {
    public int beautifulSubstrings(String s, int k) {
        int n = s.length();
        int count = 0;
        for (int i = 0; i < n; i++) {
            int vowels = 0, consonants = 0;
            for (int j = i; j < n; j++) {
                char c = s.charAt(j);
                if (isVowel(c)) {
                    vowels++;
                } else {
                    consonants++;
                }
                if (vowels == consonants && (vowels * consonants) % k == 0) {
                    count++;
                }
            }
        }
        return count;
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
}