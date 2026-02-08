#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string crackPassword(vector<int>& codeList, int numBuns) {
        int n = codeList.size();
        vector<vector<int>> buns(numBuns);
        for (int i = 0; i < n; ++i) {
            buns[i % numBuns].push_back(codeList[i]);
        }
        string result;
        for (const auto& bun : buns) {
            for (int code : bun) {
                result += to_string(code) + " ";
            }
        }
        if (!result.empty()) {
            result.pop_back();
        }
        return result;
    }
};