class Solution {
public:
    vector<int> divisibilityArray(string word, int m) {
        vector<int> res;
        long long rem = 0;
        for (char c : word) {
            rem = (rem * 10 + (c - '0')) % m;
            res.push_back(rem == 0 ? 1 : 0);
        }
        return res;
    }
};