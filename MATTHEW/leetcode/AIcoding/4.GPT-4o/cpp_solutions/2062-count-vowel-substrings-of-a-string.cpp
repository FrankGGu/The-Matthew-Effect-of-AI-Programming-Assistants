class Solution {
public:
    int countVowelSubstrings(string word) {
        int count = 0;
        int n = word.size();
        set<char> vowels = {'a', 'e', 'i', 'o', 'u'};

        for (int i = 0; i < n; ++i) {
            set<char> found;
            for (int j = i; j < n; ++j) {
                if (vowels.count(word[j])) {
                    found.insert(word[j]);
                    if (found.size() == 5) {
                        count++;
                    }
                } else {
                    break;
                }
            }
        }

        return count;
    }
};