#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minOperations(vector<int>& nums, vector<int>& target, int inc, int dec) {
        map<int, long long> count;
        for (int num : nums) {
            count[num]++;
        }

        long long operations = 0;
        for (int i = 0; i < target.size(); ++i) {
            int t = target[i];
            while (count[t] == 0) {
                t += inc;
                operations += inc;
            }
            count[t]--;
            if (t != target[i]) {
                operations += (t - target[i]) / inc;
            }
        }

        return operations;
    }
};