#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimalKSum(const vector<int>& nums, int k) {
        vector<int> sortedNums = nums;
        sort(sortedNums.begin(), sortedNums.end());
        long long result = 0;
        int prev = 0;
        for (int num : sortedNums) {
            if (num > prev + 1) {
                int count = num - prev - 1;
                int take = min(count, k);
                int a = prev + 1;
                int b = a + take - 1;
                result += static_cast<long long>(a + b) * take / 2;
                k -= take;
                if (k == 0) break;
            }
            prev = num;
        }
        if (k > 0) {
            int a = prev + 1;
            int b = a + k - 1;
            result += static_cast<long long>(a + b) * k / 2;
        }
        return result;
    }
};