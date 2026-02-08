#include <string>
#include <vector>
#include <unordered_set>

class Solution {
public:
    int countConsistentStrings(std::string allowed, std::vector<std::string>& words) {
        std::unordered_set<char> allowedSet(allowed.begin(), allowed.end());
        int count = 0;
        for (const std::string& word : words) {
            bool consistent = true;
            for (char c : word) {
                if (allowedSet.find(c) == allowedSet.end()) {
                    consistent = false;
                    break;
                }
            }
            if (consistent) {
                count++;
            }
        }
        return count;
    }
};