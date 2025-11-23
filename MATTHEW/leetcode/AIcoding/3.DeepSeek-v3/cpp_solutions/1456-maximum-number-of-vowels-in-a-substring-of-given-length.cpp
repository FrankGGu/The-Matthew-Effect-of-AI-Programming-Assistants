class Solution {
public:
    int maxVowels(string s, int k) {
        unordered_set<char> vowels = {'a', 'e', 'i', 'o', 'u'};
        int max_vowels = 0;
        int current_vowels = 0;

        for (int i = 0; i < k; ++i) {
            if (vowels.count(s[i])) {
                current_vowels++;
            }
        }
        max_vowels = current_vowels;

        for (int i = k; i < s.size(); ++i) {
            if (vowels.count(s[i - k])) {
                current_vowels--;
            }
            if (vowels.count(s[i])) {
                current_vowels++;
            }
            max_vowels = max(max_vowels, current_vowels);
        }

        return max_vowels;
    }
};