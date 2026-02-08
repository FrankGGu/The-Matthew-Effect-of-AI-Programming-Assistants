#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    int partitionString(std::string s) {
        int partitions = 1;
        std::vector<bool> seen_chars(26, false);

        for (char c : s) {
            if (seen_chars[c - 'a']) {
                partitions++;
                std::fill(seen_chars.begin(), seen_chars.end(), false);
            }
            seen_chars[c - 'a'] = true;
        }

        return partitions;
    }
};