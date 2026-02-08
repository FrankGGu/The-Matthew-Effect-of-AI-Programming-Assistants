class Solution {
public:
    vector<long long> sumPrefixScores(vector<string>& words) {
        int n = words.size();
        vector<long long> result(n);
        unordered_map<string, int> prefixCount;

        for (const string& word : words) {
            for (int i = 1; i <= word.size(); ++i) {
                string prefix = word.substr(0, i);
                prefixCount[prefix]++;
            }
        }

        for (int i = 0; i < n; ++i) {
            long long score = 0;
            for (int j = 1; j <= words[i].size(); ++j) {
                score += prefixCount[words[i].substr(0, j)];
            }
            result[i] = score;
        }

        return result;
    }
};