#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long maximumElementSum(int n, vector<int>& nums) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        long long sum = 0;
        for (auto& [num, freq] : count) {
            sum += static_cast<long long>(num) * freq;
        }

        return sum;
    }
};