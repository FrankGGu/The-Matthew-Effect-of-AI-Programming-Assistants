class Solution {
public:
    int numSplits(string s) {
        unordered_map<char, int> left, right;
        for (char c : s) {
            right[c]++;
        }
        int res = 0;
        for (char c : s) {
            left[c]++;
            if (--right[c] == 0) {
                right.erase(c);
            }
            if (left.size() == right.size()) {
                res++;
            }
        }
        return res;
    }
};