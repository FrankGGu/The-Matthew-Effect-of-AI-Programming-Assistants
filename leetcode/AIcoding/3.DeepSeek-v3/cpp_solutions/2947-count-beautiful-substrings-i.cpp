class Solution {
public:
    int beautifulSubstrings(string s, int k) {
        int n = s.size();
        int res = 0;
        for (int i = 0; i < n; ++i) {
            int vowels = 0, consonants = 0;
            for (int j = i; j < n; ++j) {
                char c = s[j];
                if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                    vowels++;
                } else {
                    consonants++;
                }
                if (vowels == consonants && (vowels * consonants) % k == 0) {
                    res++;
                }
            }
        }
        return res;
    }
};