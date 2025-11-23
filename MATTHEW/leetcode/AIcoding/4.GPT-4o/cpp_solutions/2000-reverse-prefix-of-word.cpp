class Solution {
public:
    string reversePrefix(string word, char ch) {
        int pos = word.find(ch);
        if (pos == string::npos) return word;
        string prefix = word.substr(0, pos + 1);
        reverse(prefix.begin(), prefix.end());
        return prefix + word.substr(pos + 1);
    }
};