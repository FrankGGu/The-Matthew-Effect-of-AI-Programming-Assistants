class Solution {
public:
    string decodeMessage(string key, string message) {
        unordered_map<char, char> mapping;
        char ch = 'a';
        for (char c : key) {
            if (c != ' ') {
                if (mapping.find(c) == mapping.end()) {
                    mapping[c] = ch++;
                }
            }
        }

        string decodedMessage;
        for (char c : message) {
            if (c == ' ') {
                decodedMessage += ' ';
            } else {
                decodedMessage += mapping[c];
            }
        }

        return decodedMessage;
    }
};