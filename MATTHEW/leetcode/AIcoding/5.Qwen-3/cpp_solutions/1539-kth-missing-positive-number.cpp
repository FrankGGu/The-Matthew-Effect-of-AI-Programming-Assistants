#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int findKthMissingPositive(int n, vector<int>& arr) {
        int left = 0, right = arr.size();
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] - mid - 1 < n) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return n + left;
    }
};