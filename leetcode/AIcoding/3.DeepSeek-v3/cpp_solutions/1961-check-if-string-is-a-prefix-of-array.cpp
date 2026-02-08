class Solution {
public:
    bool isPrefixString(string s, vector<string>& words) {
        string constructed;
        for (const string& word : words) {
            constructed += word;
            if (constructed == s) {
                return true;
            }
            if (constructed.size() > s.size()) {
                return false;
            }
        }
        return constructed == s;
    }
};