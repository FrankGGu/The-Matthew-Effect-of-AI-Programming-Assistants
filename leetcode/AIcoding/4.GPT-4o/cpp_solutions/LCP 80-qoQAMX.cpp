class Solution {
public:
    string organismEvolution(string s) {
        string result;
        for (char c : s) {
            if (result.empty() || result.back() != c) {
                result.push_back(c);
            }
        }
        return result;
    }
};