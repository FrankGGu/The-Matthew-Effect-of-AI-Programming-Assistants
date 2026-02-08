class Solution {
public:
    int numMatchingSubseq(string s, vector<string>& words) {
        vector<vector<int>> charIndices(26);
        for (int i = 0; i < s.size(); ++i) {
            charIndices[s[i] - 'a'].push_back(i);
        }

        int count = 0;
        for (const string& word : words) {
            int prev = -1;
            bool found = true;
            for (char c : word) {
                auto& indices = charIndices[c - 'a'];
                auto it = upper_bound(indices.begin(), indices.end(), prev);
                if (it == indices.end()) {
                    found = false;
                    break;
                }
                prev = *it;
            }
            if (found) {
                ++count;
            }
        }
        return count;
    }
};