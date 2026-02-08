class Solution {
public:
    string decodeMessage(string key, string message) {
        unordered_map<char, char> mapping;
        char replacement = 'a';

        for (char c : key) {
            if (c != ' ' && mapping.find(c) == mapping.end()) {
                mapping[c] = replacement++;
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