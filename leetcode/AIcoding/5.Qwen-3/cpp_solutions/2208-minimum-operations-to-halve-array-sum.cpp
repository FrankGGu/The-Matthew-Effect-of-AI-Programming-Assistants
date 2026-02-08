#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        int target = sum / 2;
        priority_queue<int> maxHeap;
        for (int num : nums) {
            maxHeap.push(num);
        }
        int operations = 0;
        while (sum > target) {
            int largest = maxHeap.top();
            maxHeap.pop();
            sum -= largest;
            largest /= 2;
            sum += largest;
            maxHeap.push(largest);
            operations++;
        }
        return operations;
    }
};