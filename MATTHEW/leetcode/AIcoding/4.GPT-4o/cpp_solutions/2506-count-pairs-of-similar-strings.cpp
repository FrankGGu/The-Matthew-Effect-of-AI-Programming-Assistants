class Solution {
public:
    int similarPairs(vector<string>& words) {
        unordered_map<string, int> count;
        int pairs = 0;

        for (const string& word : words) {
            sort(word.begin(), word.end());
            count[word]++;
        }

        for (const auto& [_, c] : count) {
            pairs += c * (c - 1) / 2;
        }

        return pairs;
    }
};