#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string evaluate(string s, vector<vector<string>>& knowledge) {
        unordered_map<string, string> dict;
        for (auto& k : knowledge) {
            dict[k[0]] = k[1];
        }

        string res = "";
        string curr = "";
        bool inBracket = false;

        for (char c : s) {
            if (c == '(') {
                inBracket = true;
                curr = "";
            } else if (c == ')') {
                inBracket = false;
                if (dict.count(curr)) {
                    res += dict[curr];
                } else {
                    res += "?";
                }
            } else {
                if (inBracket) {
                    curr += c;
                } else {
                    res += c;
                }
            }
        }

        return res;
    }
};