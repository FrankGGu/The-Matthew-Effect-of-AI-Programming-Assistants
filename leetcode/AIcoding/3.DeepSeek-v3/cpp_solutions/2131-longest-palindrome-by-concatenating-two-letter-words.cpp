class Solution {
public:
    int longestPalindrome(vector<string>& words) {
        unordered_map<string, int> freq;
        for (const string& word : words) {
            freq[word]++;
        }

        int res = 0;
        bool central = false;

        for (const auto& [word, count] : freq) {
            if (word[0] == word[1]) {
                if (count % 2 == 0) {
                    res += count;
                } else {
                    res += count - 1;
                    central = true;
                }
            } else {
                string reversed = string(1, word[1]) + word[0];
                if (freq.count(reversed)) {
                    res += min(count, freq[reversed]);
                }
            }
        }

        if (central) {
            res++;
        }

        return res * 2;
    }
};