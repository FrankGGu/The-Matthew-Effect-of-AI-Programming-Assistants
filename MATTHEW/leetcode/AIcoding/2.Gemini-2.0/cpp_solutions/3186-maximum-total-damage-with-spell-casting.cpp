#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumTotalDamage(vector<int>& damage, vector<int>& armor) {
        int n = damage.size();
        long long totalDamage = 0;
        int maxDamage = 0;
        for (int i = 0; i < n; ++i) {
            totalDamage += damage[i];
            maxDamage = max(maxDamage, damage[i]);
        }

        int minArmor = *min_element(armor.begin(), armor.end());

        return totalDamage - min(maxDamage, minArmor);
    }
};