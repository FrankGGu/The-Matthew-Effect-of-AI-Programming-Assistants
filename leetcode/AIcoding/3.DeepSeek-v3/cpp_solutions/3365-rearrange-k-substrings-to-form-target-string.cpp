#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool canConstruct(string s, int k, string target) {
        if (s.size() != target.size() * k) {
            return false;
        }

        unordered_map<char, int> sCount, targetCount;
        for (char c : s) {
            sCount[c]++;
        }
        for (char c : target) {
            targetCount[c]++;
        }

        for (auto& pair : targetCount) {
            if (sCount[pair.first] < pair.second * k) {
                return false;
            }
        }

        return true;
    }
};