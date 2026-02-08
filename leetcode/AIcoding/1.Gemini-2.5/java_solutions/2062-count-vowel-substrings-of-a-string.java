import java.util.Arrays;

class Solution {

    public long countVowelSubstrings(String word) {
        return countSubstringsWithAtMostKDistinctVowels(word, 5) - countSubstringsWithAtMostKDistinctVowels(word, 4);
    }

    private long countSubstringsWithAtMostKDistinctVowels(String word, int k) {
        long ans = 0;
        int left = 0;
        int[] freq = new int[26]; 
        int distinctVowels = 0;

        for (int right = 0; right < word.length(); right++) {
            char c = word.charAt(right);

            if (!isVowel(c)) {
                left = right + 1;
                Arrays.fill(freq, 0);
                distinctVowels = 0;
                continue;
            }

            if (freq[c - 'a'] == 0) {
                distinctVowels++;
            }
            freq[c - 'a']++;

            while (distinctVowels > k) {
                char leftChar = word.charAt(left);
                freq[leftChar - 'a']--;
                if (freq[leftChar - 'a'] == 0) {
                    distinctVowels--;
                }
                left++;
            }
            ans += (right - left + 1);
        }
        return ans;
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
}