class Solution {
    public int beautifulSubstrings(String s, int k) {
        int n = s.length();
        int beautifulCount = 0;

        for (int i = 0; i < n; i++) {
            int vowelsCount = 0;
            int consonantsCount = 0;
            for (int j = i; j < n; j++) {
                char c = s.charAt(j);
                if (isVowel(c)) {
                    vowelsCount++;
                } else {
                    consonantsCount++;
                }

                if (vowelsCount == consonantsCount) {
                    if ((vowelsCount * consonantsCount) % k == 0) {
                        beautifulCount++;
                    }
                }
            }
        }
        return beautifulCount;
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
}