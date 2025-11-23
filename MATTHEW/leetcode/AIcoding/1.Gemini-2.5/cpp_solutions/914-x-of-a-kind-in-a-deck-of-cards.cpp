#include <vector>
#include <unordered_map>
#include <numeric>

class Solution {
public:
    bool hasGroupsSizeX(std::vector<int>& deck) {
        if (deck.size() < 2) {
            return false;
        }
        std::unordered_map<int, int> counts;
        for (int card : deck) {
            counts[card]++;
        }
        int g = 0;
        for (auto const& pair : counts) {
            if (g == 0) {
                g = pair.second;
            } else {
                g = std::gcd(g, pair.second);
            }
        }
        return g >= 2;
    }
};