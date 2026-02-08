#include <vector>
#include <algorithm>

class Solution {
public:
    int breakfastNumber(std::vector<int>& staple, std::vector<int>& drinks, int x) {
        std::sort(staple.begin(), staple.end());
        std::sort(drinks.begin(), drinks.end());

        long long count = 0;
        int mod = 1e9 + 7;

        int i = 0;
        int j = drinks.size() - 1;

        while (i < staple.size() && j >= 0) {
            if (staple[i] + drinks[j] <= x) {
                count = (count + j + 1) % mod;
                i++;
            } else {
                j--;
            }
        }

        return static_cast<int>(count);
    }
};