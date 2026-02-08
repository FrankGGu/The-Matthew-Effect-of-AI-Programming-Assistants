class Solution {
    public int countSubstrings(String s, int k) {
        int n = s.length();
        int count = 0;
        for (int i = 0; i < n; i++) {
            int vowels = 0;
            int consonants = 0;
            boolean[] vowelPresent = new boolean[5]; // a, e, i, o, u
            for (int j = i; j < n; j++) {
                char c = s.charAt(j);
                if (c == 'a') {
                    vowels++;
                    vowelPresent[0] = true;
                } else if (c == 'e') {
                    vowels++;
                    vowelPresent[1] = true;
                } else if (c == 'i') {
                    vowels++;
                    vowelPresent[2] = true;
                } else if (c == 'o') {
                    vowels++;
                    vowelPresent[3] = true;
                } else if (c == 'u') {
                    vowels++;
                    vowelPresent[4] = true;
                } else {
                    consonants++;
                }
                if (consonants == k && vowelPresent[0] && vowelPresent[1] && vowelPresent[2] && vowelPresent[3] && vowelPresent[4]) {
                    count++;
                }
            }
        }
        return count;
    }
}