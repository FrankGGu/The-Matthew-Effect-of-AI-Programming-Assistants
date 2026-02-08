class Solution {
    public int beautifulSubstrings(String s, int k) {
        int n = s.length();
        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                String sub = s.substring(i, j + 1);
                int vowels = 0;
                int consonants = 0;
                for (char c : sub.toCharArray()) {
                    if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                        vowels++;
                    } else {
                        consonants++;
                    }
                }
                if (vowels == consonants && (vowels * consonants) % k == 0) {
                    count++;
                }
            }
        }
        return count;
    }
}