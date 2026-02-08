class Solution {
public:
    string removeAdjacentCharacters(string s) {
        string result;
        for (char c : s) {
            if (result.empty() || abs(result.back() - c) > 1) {
                result.push_back(c);
            }
        }
        return result;
    }
};