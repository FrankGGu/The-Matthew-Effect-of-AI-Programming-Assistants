class Solution {
public:
    long long countVowels(std::string word) {
        long long total_vowels = 0;
        int n = word.length();

        for (int i = 0; i < n; ++i) {
            char c = word[i];
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                total_vowels += (long long)(i + 1) * (n - i);
            }
        }

        return total_vowels;
    }
};