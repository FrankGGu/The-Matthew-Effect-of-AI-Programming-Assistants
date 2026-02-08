class Solution {
public:
    string customSortString(string order, string s) {
        unordered_map<char, int> count;
        for (char c : s) {
            count[c]++;
        }
        string result;
        for (char c : order) {
            if (count.count(c)) {
                result += string(count[c], c);
                count.erase(c);
            }
        }
        for (auto& [c, cnt] : count) {
            result += string(cnt, c);
        }
        return result;
    }
};