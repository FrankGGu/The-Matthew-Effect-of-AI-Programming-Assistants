class Solution {
public:
    int countVowelConsonantSubstrings(string s, int k) {
        int n = s.size();
        int count = 0;
        unordered_map<char, int> freq;

        for (int start = 0; start < n; start++) {
            freq.clear();
            int vowels = 0, consonants = 0;
            for (int end = start; end < n; end++) {
                char ch = s[end];
                freq[ch]++;
                if (isVowel(ch)) {
                    vowels++;
                } else if (isalpha(ch)) {
                    consonants++;
                }

                if (vowels >= 5 && consonants >= k) {
                    count++;
                }
            }
        }
        return count;
    }

private:
    bool isVowel(char ch) {
        return ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u';
    }
};