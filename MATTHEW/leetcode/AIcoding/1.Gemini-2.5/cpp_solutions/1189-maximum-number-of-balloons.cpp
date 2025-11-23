#include <string>
#include <vector>
#include <algorithm>
#include <unordered_map>

class Solution {
public:
    int maxNumberOfBalloons(std::string text) {
        std::unordered_map<char, int> counts;
        for (char c : text) {
            counts[c]++;
        }

        int b = counts['b'];
        int a = counts['a'];
        int l = counts['l'];
        int o = counts['o'];
        int n = counts['n'];

        return std::min({b, a, l / 2, o / 2, n});
    }
};