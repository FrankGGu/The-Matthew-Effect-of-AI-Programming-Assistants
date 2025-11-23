#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minPatches(int n, vector<int>& nums) {
        int patches = 0;
        long long miss = 1;
        int i = 0;
        while (miss <= n) {
            if (i < nums.size() && nums[i] <= miss) {
                miss += nums[i];
                i++;
            } else {
                miss += miss;
                patches++;
            }
        }
        return patches;
    }
};