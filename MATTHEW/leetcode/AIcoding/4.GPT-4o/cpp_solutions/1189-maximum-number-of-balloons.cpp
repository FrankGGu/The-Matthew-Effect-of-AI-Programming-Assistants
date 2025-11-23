#include <unordered_map>
#include <string>
#include <algorithm>

class Solution {
public:
    int maxNumberOfBalloons(std::string text) {
        std::unordered_map<char, int> count;
        for (char c : text) {
            count[c]++;
        }
        return std::min({count['b'], count['a'], count['l'] / 2, count['o'] / 2, count['n']});
    }
};