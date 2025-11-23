class Solution {
public:
    int maxPalindromesAfterOperations(vector<string>& words) {
        unordered_map<char, int> freq;
        for (const string& word : words) {
            for (char c : word) {
                freq[c]++;
            }
        }

        int pairs = 0;
        for (const auto& [c, cnt] : freq) {
            pairs += cnt / 2;
        }

        sort(words.begin(), words.end(), [](const string& a, const string& b) {
            return a.size() < b.size();
        });

        int res = 0;
        for (const string& word : words) {
            int required_pairs = word.size() / 2;
            if (pairs >= required_pairs) {
                res++;
                pairs -= required_pairs;
            } else {
                break;
            }
        }
        return res;
    }
};