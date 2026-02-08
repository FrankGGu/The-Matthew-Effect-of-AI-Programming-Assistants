#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<bool> camelMatch(vector<string>& queries, string pattern) {
        vector<bool> result;
        for (string& query : queries) {
            bool match = true;
            int p = 0;
            for (char c : query) {
                if (p < pattern.length() && c == pattern[p]) {
                    p++;
                } else if (isupper(c)) {
                    match = false;
                    break;
                }
            }
            if (p < pattern.length()) {
                match = false;
            }
            result.push_back(match);
        }
        return result;
    }
};