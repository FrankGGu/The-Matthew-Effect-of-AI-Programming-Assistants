#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int findInMountainArray(int target, vector<int>& mountainArr) {
        int n = mountainArr.size();

                int left = 0, right = n - 1;
        int peak = 0;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (mountainArr[mid] < mountainArr[mid + 1]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        peak = left;

                left = 0;
        right = peak;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (mountainArr[mid] == target) {
                return mid;
            } else if (mountainArr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

                left = peak;
        right = n - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (mountainArr[mid] == target) {
                return mid;
            } else if (mountainArr[mid] < target) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return -1;
    }
};