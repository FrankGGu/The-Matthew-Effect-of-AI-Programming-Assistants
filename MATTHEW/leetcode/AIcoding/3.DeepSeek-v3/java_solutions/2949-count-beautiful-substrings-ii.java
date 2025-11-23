class Solution {
    public int beautifulSubstrings(String s, int k) {
        int n = s.length();
        int[] vowels = new int[n + 1];
        int[] consonants = new int[n + 1];
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            vowels[i + 1] = vowels[i];
            consonants[i + 1] = consonants[i];
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                vowels[i + 1]++;
            } else {
                consonants[i + 1]++;
            }
        }
        int res = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j <= n; j++) {
                int v = vowels[j] - vowels[i];
                int c = consonants[j] - consonants[i];
                if (v == c && (v * c) % k == 0) {
                    res++;
                }
            }
        }
        return res;
    }
}