#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int sumOddLengthSubarrays(vector<int>& arr) {
        int n = arr.size();
        int total = 0;
        for (int i = 0; i < n; ++i) {
            int count = 0;
            for (int j = i; j < n; ++j) {
                ++count;
                if (count % 2 == 1) {
                    for (int k = i; k <= j; ++k) {
                        total += arr[k];
                    }
                }
            }
        }
        return total;
    }
};