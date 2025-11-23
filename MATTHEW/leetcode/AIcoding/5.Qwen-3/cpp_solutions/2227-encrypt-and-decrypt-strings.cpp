#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<string> encode(const vector<string>& strs) {
        vector<string> encoded;
        for (const string& s : strs) {
            string temp;
            for (char c : s) {
                temp += c;
                temp += '0';
            }
            encoded.push_back(temp);
        }
        return encoded;
    }

    vector<string> decode(const vector<string>& encoded) {
        vector<string> decoded;
        for (const string& s : encoded) {
            string temp;
            for (size_t i = 0; i < s.length(); i++) {
                if (s[i] != '0') {
                    temp += s[i];
                }
            }
            decoded.push_back(temp);
        }
        return decoded;
    }
};