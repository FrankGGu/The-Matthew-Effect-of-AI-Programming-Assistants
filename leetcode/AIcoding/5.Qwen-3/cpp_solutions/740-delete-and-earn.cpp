#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int deleteAndEarn(int n, vector<int>& nums) {
        vector<int> count(10001, 0);
        for (int num : nums) {
            count[num]++;
        }

        int prev = 0, curr = 0;
        for (int i = 1; i <= 10000; ++i) {
            int temp = curr;
            curr = max(curr, prev + i * count[i]);
            prev = temp;
        }

        return curr;
    }
};