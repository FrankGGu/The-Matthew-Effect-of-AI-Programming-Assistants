#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> successfulPairs(vector<int>& spells, vector<int>& potions, long long success) {
        sort(potions.begin(), potions.end());
        vector<int> result(spells.size());
        for (int i = 0; i < spells.size(); ++i) {
            int count = 0;
            int left = 0;
            int right = potions.size() - 1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if ((long long)spells[i] * potions[mid] >= success) {
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            result[i] = potions.size() - left;
        }
        return result;
    }
};