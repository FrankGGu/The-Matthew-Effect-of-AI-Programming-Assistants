class Solution {
public:
    long long countVowels(string word) {
        long long res = 0;
        int n = word.size();
        for (int i = 0; i < n; ++i) {
            char c = word[i];
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                res += (long long)(i + 1) * (n - i);
            }
        }
        return res;
    }
};