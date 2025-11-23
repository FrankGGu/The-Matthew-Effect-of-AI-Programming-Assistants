class Solution {
public:
    string crackPassword(vector<int>& password) {
        vector<string> strs;
        for (int num : password) {
            strs.push_back(to_string(num));
        }
        sort(strs.begin(), strs.end(), [](const string& a, const string& b) {
            return a + b < b + a;
        });
        string result;
        for (string s : strs) {
            result += s;
        }
        return result;
    }
};