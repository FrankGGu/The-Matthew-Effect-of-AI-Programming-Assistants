#include <vector>
#include <algorithm>

class Solution {
public:
    char nextGreatestLetter(std::vector<char>& letters, char target) {
        auto it = std::upper_bound(letters.begin(), letters.end(), target);

        if (it == letters.end()) {
            return letters[0];
        } else {
            return *it;
        }
    }
};