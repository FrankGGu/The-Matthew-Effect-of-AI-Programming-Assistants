class Solution {
public:
    vector<int> vowelStrings(vector<string>& words, vector<vector<int>>& queries) {
        unordered_set<char> vowels = {'a', 'e', 'i', 'o', 'u'};
        int n = words.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            char first = words[i][0];
            char last = words[i].back();
            prefix[i + 1] = prefix[i] + (vowels.count(first) && vowels.count(last));
        }
        vector<int> res;
        for (auto& q : queries) {
            int l = q[0], r = q[1];
            res.push_back(prefix[r + 1] - prefix[l]);
        }
        return res;
    }
};