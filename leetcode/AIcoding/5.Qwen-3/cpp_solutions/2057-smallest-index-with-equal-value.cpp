#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int smallestEqual(int n, vector<int>& nums) {
        int minIndex = -1;
        for (int i = 0; i < n; ++i) {
            if (nums[i] == i) {
                if (minIndex == -1 || i < minIndex) {
                    minIndex = i;
                }
            }
        }
        return minIndex;
    }
};