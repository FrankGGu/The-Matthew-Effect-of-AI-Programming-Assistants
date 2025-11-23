class Solution {
public:
    int numEquivDominoPairs(vector<vector<int>>& dominoes) {
        unordered_map<int, int> count;
        int pairs = 0;

        for (const auto& domino : dominoes) {
            int a = min(domino[0], domino[1]);
            int b = max(domino[0], domino[1]);
            count[a * 10 + b]++;
        }

        for (const auto& entry : count) {
            pairs += entry.second * (entry.second - 1) / 2;
        }

        return pairs;
    }
};