#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int removeTeeth(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;
        if (n == 1) return nums[0];

        priority_queue<int, vector<int>, greater<int>> pq(nums.begin(), nums.end());

        int result = 0;

        while (pq.size() > 1) {
            int a = pq.top();
            pq.pop();
            int b = pq.top();
            pq.pop();
            int sum = a + b;
            result += sum;
            pq.push(sum);
        }

        return result;
    }
};