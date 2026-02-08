class Solution {
public:
    vector<string> divideString(string s, int k, char fill) {
        vector<string> result;
        int n = s.size();
        for (int i = 0; i < n; i += k) {
            string group = s.substr(i, k);
            if (group.size() < k) {
                group += string(k - group.size(), fill);
            }
            result.push_back(group);
        }
        return result;
    }
};