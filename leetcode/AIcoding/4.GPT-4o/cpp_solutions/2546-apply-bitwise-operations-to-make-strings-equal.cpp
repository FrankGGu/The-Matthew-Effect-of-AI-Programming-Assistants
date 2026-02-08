class Solution {
public:
    bool makeStringsEqual(string s, string target) {
        if (s == target) return true;
        return (s.find('1') != string::npos && target.find('1') != string::npos);
    }
};