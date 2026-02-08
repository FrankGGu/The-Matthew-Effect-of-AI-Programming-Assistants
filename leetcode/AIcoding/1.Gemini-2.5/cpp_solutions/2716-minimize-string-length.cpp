#include <string>
#include <vector>

class Solution {
public:
    int minimizedStringLength(std::string s) {
        std::vector<int> counts(26, 0);

        for (char c : s) {
            counts[c - 'a']++;
        }

        int minLength = 0;
        for (int count : counts) {
            if (count % 2 == 1) {
                minLength++;
            }
        }

        return minLength;
    }
};