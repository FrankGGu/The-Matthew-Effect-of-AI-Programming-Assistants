#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> semiOrderedPermutation(vector<int>& nums) {
        int n = nums.size();
        vector<int> result = nums;
        for (int i = 0; i < n - 1; ++i) {
            if (result[i] == i + 1) continue;
            for (int j = i + 1; j < n; ++j) {
                if (result[j] == i + 1) {
                    swap(result[i], result[j]);
                    break;
                }
            }
        }
        return result;
    }
};