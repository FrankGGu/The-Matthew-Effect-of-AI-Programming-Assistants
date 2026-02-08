#include <vector>
#include <numeric> // Required for std::gcd in C++17 and later
#include <map>     // Required for std::map

class Solution {
public:
    bool hasGroupsSizeX(std::vector<int>& deck) {
        if (deck.empty()) {
            return false;
        }

        std::map<int, int> counts;
        for (int card : deck) {
            counts[card]++;
        }

        int result_gcd = 0; 
        for (auto const& pair : counts) {
            result_gcd = std::gcd(result_gcd, pair.second);
        }

        return result_gcd >= 2;
    }
};