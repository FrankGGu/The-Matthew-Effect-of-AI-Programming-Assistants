#include <iostream>
#include <vector>
#include <string>
#include <map>

using namespace std;

class Solution {
public:
    bool checkIfCanBreak(vector<string>& s1, vector<string>& s2) {
        map<char, int> count1;
        map<char, int> count2;

        for (const string& str : s1) {
            for (char c : str) {
                count1[c]++;
            }
        }

        for (const string& str : s2) {
            for (char c : str) {
                count2[c]++;
            }
        }

        vector<char> chars;
        for (auto& p : count1) {
            chars.push_back(p.first);
        }
        for (auto& p : count2) {
            chars.push_back(p.first);
        }

        for (int i = 0; i < chars.size(); ++i) {
            if (count1[chars[i]] < count2[chars[i]]) {
                return false;
            }
        }

        return true;
    }
};