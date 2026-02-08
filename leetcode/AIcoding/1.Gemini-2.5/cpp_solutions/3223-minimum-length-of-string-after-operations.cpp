#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    int minimumLength(std::string s) {
        std::vector<int> counts(26, 0);
        for (char c : s) {
            counts[c - 'a']++;
        }

        int result = 0;
        for (int count : counts) {
            result += count % 2;
        }

        return result;
    }
};