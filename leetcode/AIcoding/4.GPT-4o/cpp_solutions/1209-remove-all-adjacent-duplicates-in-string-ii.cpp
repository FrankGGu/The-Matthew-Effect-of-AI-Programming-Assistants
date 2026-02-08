class Solution {
public:
    string removeDuplicates(string s, int k) {
        vector<pair<char, int>> stk;
        for (char c : s) {
            if (!stk.empty() && stk.back().first == c) {
                stk.back().second++;
            } else {
                stk.emplace_back(c, 1);
            }
            if (stk.back().second == k) {
                stk.pop_back();
            }
        }
        string result;
        for (auto& [ch, count] : stk) {
            result.append(count, ch);
        }
        return result;
    }
};