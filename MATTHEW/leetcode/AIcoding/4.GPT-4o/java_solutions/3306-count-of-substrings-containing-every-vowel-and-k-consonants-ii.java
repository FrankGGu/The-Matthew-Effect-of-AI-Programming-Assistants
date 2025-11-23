class Solution {
    public int countVowelSubstrings(String s, int k) {
        int n = s.length(), count = 0;
        int[] vowelCount = new int[5]; // a, e, i, o, u
        int vowels = 0, consonants = 0;
        int left = 0;

        for (int right = 0; right < n; right++) {
            char c = s.charAt(right);
            if (isVowel(c)) {
                if (vowelCount[getIndex(c)]++ == 0) {
                    vowels++;
                }
            } else {
                consonants++;
            }

            while (vowels == 5 && consonants > k) {
                char leftChar = s.charAt(left++);
                if (isVowel(leftChar)) {
                    if (--vowelCount[getIndex(leftChar)] == 0) {
                        vowels--;
                    }
                } else {
                    consonants--;
                }
            }

            if (vowels == 5 && consonants == k) {
                count++;
            }
        }

        return count;
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    private int getIndex(char c) {
        switch (c) {
            case 'a': return 0;
            case 'e': return 1;
            case 'i': return 2;
            case 'o': return 3;
            case 'u': return 4;
            default: return -1;
        }
    }
}