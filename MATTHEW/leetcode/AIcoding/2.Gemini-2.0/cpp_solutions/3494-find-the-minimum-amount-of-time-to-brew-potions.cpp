#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minPotionBrewingTime(vector<int>& potions, int success, long long extraIngredient) {
        sort(potions.begin(), potions.end());
        long long ans = 0;
        for (int potion : potions) {
            long long need = (success + potion - 1) / potion;
            if (need <= 1) continue;
            ans += need - 1;
        }
        return ans * extraIngredient;
    }
};