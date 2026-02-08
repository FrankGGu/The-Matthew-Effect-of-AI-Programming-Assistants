#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool canBePlaced(vector<int>& ages) {
        sort(ages.begin(), ages.end());
        int n = ages.size();
        for (int i = 0; i < n - 1; ++i) {
            if (ages[i + 1] < 2 * ages[i]) {
                return false;
            }
        }
        return true;
    }
};