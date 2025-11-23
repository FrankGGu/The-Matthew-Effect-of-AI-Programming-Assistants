#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int findSpecialInteger(const vector<int>& arr) {
        int n = arr.size();
        int target = n / 4;
        int count = 1;
        for (int i = 1; i < n; ++i) {
            if (arr[i] == arr[i - 1]) {
                ++count;
                if (count > target) {
                    return arr[i];
                }
            } else {
                count = 1;
            }
        }
        return arr[0];
    }
};