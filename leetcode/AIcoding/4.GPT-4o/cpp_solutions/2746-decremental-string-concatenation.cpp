class Solution {
public:
    string concat(string s) {
        string result;
        for (char ch : s) {
            result += ch;
            s.pop_back();
        }
        return result;
    }
};