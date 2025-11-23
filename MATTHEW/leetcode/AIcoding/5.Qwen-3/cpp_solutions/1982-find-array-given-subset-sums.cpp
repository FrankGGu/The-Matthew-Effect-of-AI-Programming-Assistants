#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> findArray(vector<int>& subsetSums) {
        sort(subsetSums.begin(), subsetSums.end());
        int n = subsetSums.size();
        vector<int> result;
        int sum = 0;
        for (int i = 0; i < n; i++) {
            if (subsetSums[i] != sum) {
                result.push_back(subsetSums[i] - sum);
                sum += result.back();
            }
        }
        return result;
    }
};