#include <vector>
#include <string>
#include <algorithm>
#include <set>

class Solution {
public:
    int maximumNumberOfStringPairs(std::vector<std::string>& words) {
        int pairs = 0;
        std::set<std::string> seen_strings;

        for (const std::string& s : words) {
            std::string reversed_s = s;
            std::reverse(reversed_s.begin(), reversed_s.end());

            if (seen_strings.count(reversed_s)) {
                pairs++;
                seen_strings.erase(reversed_s);
            } else {
                seen_strings.insert(s);
            }
        }

        return pairs;
    }
};