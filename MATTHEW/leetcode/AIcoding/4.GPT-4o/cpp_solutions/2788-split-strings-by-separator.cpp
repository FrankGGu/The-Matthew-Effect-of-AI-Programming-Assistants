class Solution {
public:
    vector<string> splitStrings(string s, char separator) {
        vector<string> result;
        stringstream ss(s);
        string token;
        while (getline(ss, token, separator)) {
            if (!token.empty()) {
                result.push_back(token);
            }
        }
        return result;
    }
};