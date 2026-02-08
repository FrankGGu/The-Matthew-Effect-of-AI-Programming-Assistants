class Solution {
public:
    int countVowelSubstrings(string word, int k) {
        int n = word.size();
        int res = 0;
        unordered_set<char> vowels = {'a', 'e', 'i', 'o', 'u'};

        for (int i = 0; i < n; ++i) {
            unordered_set<char> currentVowels;
            int consonants = 0;
            for (int j = i; j < n; ++j) {
                char c = word[j];
                if (vowels.count(c)) {
                    currentVowels.insert(c);
                } else {
                    consonants++;
                }
                if (currentVowels.size() == 5 && consonants == k) {
                    res++;
                }
            }
        }
        return res;
    }
};