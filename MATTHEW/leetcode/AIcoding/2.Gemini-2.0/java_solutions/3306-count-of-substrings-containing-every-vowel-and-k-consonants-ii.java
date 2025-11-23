class Solution {
    public long countVowelSubstrings(String word, int k) {
        int n = word.length();
        long ans = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                String sub = word.substring(i, j + 1);
                if (isVowelSubstring(sub, k)) {
                    ans++;
                }
            }
        }
        return ans;
    }

    private boolean isVowelSubstring(String s, int k) {
        int vowelCount = 0;
        int a = 0, e = 0, i = 0, o = 0, u = 0;
        int consonantCount = 0;

        for (char c : s.toCharArray()) {
            if (c == 'a') {
                a++;
                vowelCount++;
            } else if (c == 'e') {
                e++;
                vowelCount++;
            } else if (c == 'i') {
                i++;
                vowelCount++;
            } else if (c == 'o') {
                o++;
                vowelCount++;
            } else if (c == 'u') {
                u++;
                vowelCount++;
            } else {
                consonantCount++;
            }
        }

        return a > 0 && e > 0 && i > 0 && o > 0 && u > 0 && consonantCount == k;
    }
}