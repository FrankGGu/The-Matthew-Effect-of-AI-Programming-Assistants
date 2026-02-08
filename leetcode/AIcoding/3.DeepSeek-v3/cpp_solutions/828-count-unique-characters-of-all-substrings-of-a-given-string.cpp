class Solution {
public:
    int uniqueLetterString(string s) {
        unordered_map<char, vector<int>> index;
        for (int i = 0; i < s.size(); ++i) {
            index[s[i]].push_back(i);
        }
        int res = 0;
        for (auto &[c, vec] : index) {
            for (int i = 0; i < vec.size(); ++i) {
                int left = i == 0 ? vec[i] + 1 : vec[i] - vec[i - 1];
                int right = i == vec.size() - 1 ? s.size() - vec[i] : vec[i + 1] - vec[i];
                res += left * right;
            }
        }
        return res;
    }
};