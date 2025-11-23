#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> letterCasePermutation(string s) {
        vector<string> result;
        result.push_back(s);
        for (int i = 0; i < s.size(); ++i) {
            if (isalpha(s[i])) {
                int size = result.size();
                for (int j = 0; j < size; ++j) {
                    string temp = result[j];
                    temp[i] = islower(temp[i]) ? toupper(temp[i]) : tolower(temp[i]);
                    result.push_back(temp);
                }
            }
        }
        return result;
    }
};