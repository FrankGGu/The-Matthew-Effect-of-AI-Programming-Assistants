class Solution {
public:
    int findPermutationDifference(string s, string t) {
        unordered_map<char, int> posS, posT;
        for (int i = 0; i < s.size(); ++i) {
            posS[s[i]] = i;
            posT[t[i]] = i;
        }
        int res = 0;
        for (auto& c : s) {
            res += abs(posS[c] - posT[c]);
        }
        return res;
    }
};