#include <string>
#include <unordered_set>

class Solution {
public:
    bool hasAllCodes(std::string s, int k) {
        if (s.length() < k) {
            return false;
        }

        std::unordered_set<int> seen_codes;
        int current_hash = 0;
        int all_ones = (1 << k) - 1;

        for (int i = 0; i < k; ++i) {
            current_hash = (current_hash << 1) | (s[i] - '0');
        }
        seen_codes.insert(current_hash);

        for (int i = k; i < s.length(); ++i) {
            current_hash = ((current_hash << 1) & all_ones) | (s[i] - '0');
            seen_codes.insert(current_hash);
        }

        return seen_codes.size() == (1 << k);
    }
};