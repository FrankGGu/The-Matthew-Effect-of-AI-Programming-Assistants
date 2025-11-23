class Solution {
public:
    long long countVowels(string word) {
        long long total = 0;
        int n = word.size();
        for (int i = 0; i < n; ++i) {
            if (word[i] == 'a' || word[i] == 'e' || word[i] == 'i' || word[i] == 'o' || word[i] == 'u') {
                total += (i + 1) * (n - i);
            }
        }
        return total;
    }
};