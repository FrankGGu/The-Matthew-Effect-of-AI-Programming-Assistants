#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> pancakeSorting(vector<int>& arr) {
        vector<int> result;
        int n = arr.size();

        for (int i = n; i > 1; --i) {
            int maxIndex = 0;
            for (int j = 1; j < i; ++j) {
                if (arr[j] > arr[maxIndex]) {
                    maxIndex = j;
                }
            }

            if (maxIndex == i - 1) {
                continue;
            }

            if (maxIndex != 0) {
                reverse(arr.begin(), arr.begin() + maxIndex + 1);
                result.push_back(maxIndex + 1);
            }

            reverse(arr.begin(), arr.begin() + i);
            result.push_back(i);
        }

        return result;
    }
};