#include <iostream>
#include <vector>
#include <string>
#include <map>

using namespace std;

class Solution {
public:
    string decodeMessage(string key, string message) {
        map<char, char> mapping;
        int index = 0;
        for (char c : key) {
            if (c != ' ' && mapping.find(c) == mapping.end()) {
                mapping[c] = 'a' + index++;
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