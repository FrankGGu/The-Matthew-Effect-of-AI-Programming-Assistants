#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findTheDistanceValue(vector<int>& arr1, vector<int>& arr2, int d) {
        sort(arr2.begin(), arr2.end());
        int count = 0;
        for (int num : arr1) {
            bool valid = true;
            for (int j = 0; j < arr2.size(); ++j) {
                if (abs(num - arr2[j]) <= d) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                ++count;
            }
        }
        return count;
    }
};