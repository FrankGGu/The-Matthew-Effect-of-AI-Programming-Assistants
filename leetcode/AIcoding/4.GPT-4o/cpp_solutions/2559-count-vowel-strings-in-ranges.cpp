class Solution {
public:
    vector<int> vowelStrings(vector<string>& words, vector<vector<int>>& queries) {
        vector<int> prefixSum(words.size() + 1, 0);
        for (int i = 0; i < words.size(); ++i) {
            prefixSum[i + 1] = prefixSum[i] + (isVowelString(words[i]) ? 1 : 0);
        }
        vector<int> result;
        for (const auto& query : queries) {
            result.push_back(prefixSum[query[1] + 1] - prefixSum[query[0]]);
        }
        return result;
    }

private:
    bool isVowelString(const string& word) {
        return !word.empty() && isVowel(word.front()) && isVowel(word.back());
    }

    bool isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
};