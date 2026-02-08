#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countMatches(vector<vector<string>>& items, string ruleKey, string ruleValue) {
        int index = 0;
        if (ruleKey == "name") {
            index = 0;
        } else if (ruleKey == "type") {
            index = 1;
        } else if (ruleKey == "color") {
            index = 2;
        }
        int count = 0;
        for (const auto& item : items) {
            if (item[index] == ruleValue) {
                count++;
            }
        }
        return count;
    }
};