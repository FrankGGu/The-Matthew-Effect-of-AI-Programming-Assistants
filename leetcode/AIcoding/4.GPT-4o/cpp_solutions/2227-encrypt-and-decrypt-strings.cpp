class Solution {
public:
    string encode(vector<string>& strs) {
        string encoded = "";
        for (const string& str : strs) {
            encoded += to_string(str.size()) + '#' + str;
        }
        return encoded;
    }

    vector<string> decode(string s) {
        vector<string> decoded;
        int i = 0;
        while (i < s.size()) {
            int j = s.find('#', i);
            int length = stoi(s.substr(i, j - i));
            decoded.push_back(s.substr(j + 1, length));
            i = j + 1 + length;
        }
        return decoded;
    }
};