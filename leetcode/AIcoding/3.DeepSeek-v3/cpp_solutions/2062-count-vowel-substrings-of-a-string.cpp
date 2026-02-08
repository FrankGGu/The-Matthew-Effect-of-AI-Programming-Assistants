class Solution {
public:
    int countVowelSubstrings(string word) {
        int n = word.size();
        int res = 0;
        unordered_set<char> vowels = {'a', 'e', 'i', 'o', 'u'};

        for (int i = 0; i < n; ++i) {
            unordered_set<char> temp;
            for (int j = i; j < n; ++j) {
                if (vowels.find(word[j]) == vowels.end()) {
                    break;
                }
                temp.insert(word[j]);
                if (temp.size() == 5) {
                    res++;
                }
            }
        }
        return res;
    }
};