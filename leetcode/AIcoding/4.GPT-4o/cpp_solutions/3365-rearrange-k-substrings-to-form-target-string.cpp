#include <string>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool canRearrange(vector<string>& substrings, string target) {
        unordered_map<char, int> targetCount;
        for (char c : target) {
            targetCount[c]++;
        }

        unordered_map<char, int> substrCount;
        for (const string& s : substrings) {
            for (char c : s) {
                substrCount[c]++;
            }
        }

        for (const auto& [c, count] : targetCount) {
            if (substrCount[c] < count) {
                return false;
            }
        }

        return true;
    }
};