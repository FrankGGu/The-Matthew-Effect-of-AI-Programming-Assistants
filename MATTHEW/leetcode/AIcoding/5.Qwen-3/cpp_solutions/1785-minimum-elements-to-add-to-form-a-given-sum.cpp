#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minElements(vector<int>& nums, int limit, int goal) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        int diff = goal - sum;
        return (diff + limit - 1) / limit;
    }
};