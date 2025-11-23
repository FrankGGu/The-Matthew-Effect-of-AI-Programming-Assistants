class Solution {
    public int countSubstrings(String s, int k) {
        int n = s.length();
        int count = 0;
        for (int i = 0; i < n; i++) {
            int vowels = 0;
            int consonants = 0;
            for (int j = i; j < n; j++) {
                char c = s.charAt(j);
                if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                    vowels++;
                } else {
                    consonants++;
                }
                if (vowels >= 1 && consonants >= k) {
                    count++;
                }
            }
        }
        return count;
    }
}