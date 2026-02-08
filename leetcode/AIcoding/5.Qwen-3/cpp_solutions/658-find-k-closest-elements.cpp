#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> findClosestElements(vector<int>& arr, int k, int x) {
        int left = 0;
        int right = arr.size() - k;

        while (left < right) {
            int mid = (left + right) / 2;
            if (arr[mid + k] - x < x - arr[mid]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return vector<int>(arr.begin() + left, arr.begin() + left + k);
    }
};