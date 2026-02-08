#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int specialArray(vector<int>& nums) {
        int count = 0;
        for (int i = 0; i <= 1000; ++i) {
            int temp = 0;
            for (int num : nums) {
                if (num >= i) {
                    temp++;
                }
            }
            if (temp == i) {
                return i;
            }
        }
        return -1;
    }
};