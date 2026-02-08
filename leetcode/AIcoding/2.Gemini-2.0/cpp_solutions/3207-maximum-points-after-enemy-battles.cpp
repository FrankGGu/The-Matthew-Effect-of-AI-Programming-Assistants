#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxPoints(vector<vector<int>>& enemies, int armor) {
        long long sum = 0;
        int maxAttack = 0;
        for (auto& enemy : enemies) {
            sum += enemy[0];
            maxAttack = max(maxAttack, enemy[0]);
        }

        return sum - min(armor, maxAttack);
    }
};