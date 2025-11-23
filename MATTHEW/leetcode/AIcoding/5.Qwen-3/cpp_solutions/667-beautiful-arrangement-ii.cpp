#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> constructArray(int n, int k) {
        vector<int> result;
        int left = 1, right = n;
        for (int i = 0; i <= k; ++i) {
            if (i % 2 == 0) {
                result.push_back(left++);
            } else {
                result.push_back(right--);
            }
        }
        for (int i = left; i <= right; ++i) {
            result.push_back(i);
        }
        return result;
    }
};