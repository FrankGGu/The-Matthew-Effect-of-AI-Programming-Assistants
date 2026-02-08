#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findClosest(int n, vector<int>& stores, int location) {
        int closest = -1;
        int min_diff = INT_MAX;
        sort(stores.begin(), stores.end());

        for (int store : stores) {
            int diff = abs(store - location);
            if (diff < min_diff) {
                min_diff = diff;
                closest = store;
            }
        }

        return closest;
    }
};