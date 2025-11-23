#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    bool canConstruct(std::string s, int k) {
        if (k > s.length()) {
            return false;
        }

        std::vector<int> counts(26, 0);
        for (char c : s) {
            counts[c - 'a']++;
        }

        int odd_frequency_chars = 0;
        for (int count : counts) {
            if (count % 2 != 0) {
                odd_frequency_chars++;
            }
        }

        if (odd_frequency_chars > k) {
            return false;
        }

        return true;
    }
};