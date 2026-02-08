#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> replaceElements(vector<int>& arr) {
        int maxVal = arr.back();
        arr.back() = -1;
        for (int i = arr.size() - 2; i >= 0; i--) {
            int temp = arr[i];
            arr[i] = maxVal;
            maxVal = max(maxVal, temp);
        }
        return arr;
    }
};