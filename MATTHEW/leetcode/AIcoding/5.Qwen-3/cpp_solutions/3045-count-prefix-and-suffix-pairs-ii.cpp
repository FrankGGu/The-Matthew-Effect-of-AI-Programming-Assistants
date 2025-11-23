#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countPrefixSuffixPairs(vector<string>& nums) {
        unordered_map<string, int> prefixSuffixCount;
        int result = 0;

        for (const string& s : nums) {
            for (auto it = prefixSuffixCount.begin(); it != prefixSuffixCount.end(); ++it) {
                if (s.find(it->first) == 0 && s.rfind(it->first) == s.size() - it->first.size()) {
                    result += it->second;
                }
            }
            prefixSuffixCount[s]++;
        }

        return result;
    }
};