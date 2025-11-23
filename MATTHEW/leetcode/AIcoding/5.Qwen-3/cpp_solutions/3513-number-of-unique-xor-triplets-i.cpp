#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int uniqueXorTriplets(vector<int>& nums) {
        int n = nums.size();
        unordered_set<int> seen;
        int count = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                for (int k = j + 1; k < n; ++k) {
                    int xorVal = nums[i] ^ nums[j] ^ nums[k];
                    if (seen.find(xorVal) == seen.end()) {
                        count++;
                        seen.insert(xorVal);
                    }
                }
            }
        }

        return count;
    }
};