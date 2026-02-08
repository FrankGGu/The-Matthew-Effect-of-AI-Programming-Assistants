#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<long long> maxAndMinSubsequences(vector<int>& nums, int k) {
        int n = nums.size();
        priority_queue<int> max_heap;
        priority_queue<int, vector<int>, greater<int>> min_heap;

        for (int i = 0; i < n; ++i) {
            max_heap.push(nums[i]);
            min_heap.push(nums[i]);

            if (max_heap.size() > k) {
                max_heap.pop();
            }
            if (min_heap.size() > k) {
                min_heap.pop();
            }
        }

        long long max_sum = 0;
        long long min_sum = 0;

        vector<int> max_vec, min_vec;

        while (!max_heap.empty()) {
            max_vec.push_back(max_heap.top());
            max_heap.pop();
        }
        while (!min_heap.empty()) {
            min_vec.push_back(min_heap.top());
            min_heap.pop();
        }

        for(int i = 0; i < max_vec.size(); ++i) {
          max_sum += max_vec[i];
        }

        for(int i = 0; i < min_vec.size(); ++i) {
          min_sum += min_vec[i];
        }

        return {max_sum, min_sum};
    }
};