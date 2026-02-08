class Solution {
public:
    string decodeMessage(string key, string message) {
        unordered_map<char, char> mapping;
        char current = 'a';
        for (char c : key) {
            if (c != ' ' && mapping.find(c) == mapping.end()) {
                mapping[c] = current++;
            }
        }
        string result;
        for (char c : message) {
            if (c == ' ') {
                result += ' ';
            } else {
                result += mapping[c];
            }
        }
        return result;
    }
};