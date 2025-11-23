class Solution {
    public int longestBeautifulSubstring(String word) {
        int n = word.length();
        int ans = 0;
        for (int i = 0; i < n;) {
            int j = i;
            int vowelIndex = 0;
            String vowels = "aeiou";
            while (j < n && word.charAt(j) == vowels.charAt(vowelIndex)) {
                j++;
            }
            if (vowelIndex < 4) {
                i = j;
                continue;
            }

            int k = i;
            int currentVowelIndex = 0;
            while (k < n) {
                if (word.charAt(k) == vowels.charAt(currentVowelIndex)) {
                    k++;
                } else if (currentVowelIndex < 4 && word.charAt(k) == vowels.charAt(currentVowelIndex + 1)) {
                    currentVowelIndex++;
                    k++;
                } else {
                    break;
                }

            }

            if (currentVowelIndex == 4) {
                ans = Math.max(ans, k - i);
            }
            i = k;

        }
        return ans;
    }
}