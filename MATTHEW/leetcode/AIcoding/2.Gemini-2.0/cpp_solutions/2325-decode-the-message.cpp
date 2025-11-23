#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string decodeMessage(string key, string message) {
        unordered_map<char, char> charMap;
        char currentChar = 'a';
        for (char c : key) {
            if (c != ' ' && charMap.find(c) == charMap.end()) {
                charMap[c] = currentChar;
                currentChar++;
            }
        }

        string decodedMessage = "";
        for (char c : message) {
            if (c == ' ') {
                decodedMessage += ' ';
            } else {
                decodedMessage += charMap[c];
            }
        }

        return decodedMessage;
    }
};