#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countTriplets(vector<int>& nums) {
        int n = nums.size();
        unordered_set<int> xorSet;
        int result = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int xorIJ = nums[i] ^ nums[j];
                xorSet.insert(xorIJ);
            }
        }

        for (int k = 0; k < n; ++k) {
            for (int i = 0; i < k; ++i) {
                int xorIK = nums[i] ^ nums[k];
                if (xorSet.find(xorIK) != xorSet.end()) {
                    ++result;
                }
            }
        }

        return result;
    }
};