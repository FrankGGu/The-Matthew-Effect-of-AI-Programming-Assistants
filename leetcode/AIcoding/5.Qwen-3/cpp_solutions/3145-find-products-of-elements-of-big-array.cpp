#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<long long> findProductsOfElements(vector<int>& nums) {
        int n = nums.size();
        vector<long long> result(n, 1);

        long long leftProduct = 1;
        for (int i = 0; i < n; ++i) {
            result[i] = leftProduct;
            leftProduct *= nums[i];
        }

        long long rightProduct = 1;
        for (int i = n - 1; i >= 0; --i) {
            result[i] *= rightProduct;
            rightProduct *= nums[i];
        }

        return result;
    }
};