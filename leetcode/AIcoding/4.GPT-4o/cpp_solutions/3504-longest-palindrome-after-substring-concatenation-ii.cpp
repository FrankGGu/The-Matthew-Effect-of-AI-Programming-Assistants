class Solution {
public:
    int longestPalindrome(vector<string>& words) {
        unordered_map<string, int> count;
        int pairs = 0, single = 0;

        for (const string& word : words) {
            count[word]++;
        }

        for (auto& [word, c] : count) {
            string rev_word = string(word.rbegin(), word.rend());
            if (rev_word == word) {
                pairs += c / 2;
                if (c % 2 == 1) single = 1;
            } else if (count.count(rev_word)) {
                pairs += min(c, count[rev_word]);
            }
        }

        return pairs * 4 + single * 2;
    }
};