#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int powerOfHeroes(std::vector<int>& heroes) {
        int n = heroes.size();
        std::sort(heroes.begin(), heroes.end());
        int sum = std::accumulate(heroes.begin(), heroes.end(), 0);
        int maxHero = heroes.back();

        if (maxHero > sum - maxHero) {
            return -1;
        }

        return sum;
    }
};