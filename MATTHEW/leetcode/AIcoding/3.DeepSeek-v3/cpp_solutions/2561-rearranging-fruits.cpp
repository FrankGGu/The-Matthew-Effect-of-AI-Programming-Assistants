#include <vector>
#include <unordered_map>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    long long minCost(vector<int>& basket1, vector<int>& basket2) {
        unordered_map<int, int> freq;
        for (int fruit : basket1) freq[fruit]++;
        for (int fruit : basket2) freq[fruit]--;

        vector<int> swaps;
        for (auto& [fruit, count] : freq) {
            if (count % 2 != 0) return -1;
            int times = abs(count) / 2;
            for (int i = 0; i < times; ++i) {
                swaps.push_back(fruit);
            }
        }

        sort(swaps.begin(), swaps.end());

        int min_fruit = INT_MAX;
        for (int fruit : basket1) min_fruit = min(min_fruit, fruit);
        for (int fruit : basket2) min_fruit = min(min_fruit, fruit);

        long long res = 0;
        int n = swaps.size();
        for (int i = 0; i < n / 2; ++i) {
            res += min(swaps[i], 2 * min_fruit);
        }

        return res;
    }
};