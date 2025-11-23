class Solution {
public:
    int countVowelSubstring(string s, int k) {
        int n = s.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            int vowels = 0, consonants = 0;
            unordered_map<char, int> freq;
            for (int j = i; j < n; ++j) {
                if (isVowel(s[j])) {
                    vowels++;
                    freq[s[j]]++;
                } else {
                    consonants++;
                }

                if (vowels >= 5 && consonants == k) {
                    count++;
                }
            }
        }
        return count;
    }

    bool isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
};