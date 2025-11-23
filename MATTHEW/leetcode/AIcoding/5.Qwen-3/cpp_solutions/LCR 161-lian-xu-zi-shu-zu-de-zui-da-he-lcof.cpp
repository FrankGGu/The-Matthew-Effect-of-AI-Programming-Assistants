#include <iostream>
#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int longestSalesDays(vector<int>& sales) {
        unordered_map<int, int> prefixSum;
        int sum = 0;
        int maxDays = 0;
        prefixSum[0] = -1;
        for (int i = 0; i < sales.size(); ++i) {
            sum += sales[i];
            if (prefixSum.find(sum) != prefixSum.end()) {
                maxDays = max(maxDays, i - prefixSum[sum]);
            } else {
                prefixSum[sum] = i;
            }
        }
        return maxDays;
    }
};