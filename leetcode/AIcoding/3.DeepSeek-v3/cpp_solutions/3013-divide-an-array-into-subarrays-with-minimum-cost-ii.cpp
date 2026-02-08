#include <vector>
#include <set>
#include <climits>

using namespace std;

class Solution {
public:
    long long minimumCost(vector<int>& nums, int k, int dist) {
        int n = nums.size();
        multiset<int> top_k_minus_1;
        multiset<int> rest;
        long long sum_top = 0;
        long long res = LLONG_MAX;

        for (int i = 1; i < n; ++i) {
            if (top_k_minus_1.size() < k - 1) {
                top_k_minus_1.insert(nums[i]);
                sum_top += nums[i];
            } else if (!top_k_minus_1.empty() && nums[i] < *top_k_minus_1.rbegin()) {
                int val = *top_k_minus_1.rbegin();
                sum_top -= val;
                top_k_minus_1.erase(top_k_minus_1.find(val));
                rest.insert(val);
                top_k_minus_1.insert(nums[i]);
                sum_top += nums[i];
            } else {
                rest.insert(nums[i]);
            }

            if (i >= dist + 1) {
                int left = i - dist - 1;
                if (rest.find(nums[left]) != rest.end()) {
                    rest.erase(rest.find(nums[left]));
                } else {
                    sum_top -= nums[left];
                    top_k_minus_1.erase(top_k_minus_1.find(nums[left]));
                    if (!rest.empty()) {
                        int val = *rest.begin();
                        sum_top += val;
                        top_k_minus_1.insert(val);
                        rest.erase(rest.find(val));
                    }
                }
            }

            if (i >= dist && top_k_minus_1.size() == k - 1) {
                res = min(res, (long long)nums[0] + sum_top);
            }
        }

        return res;
    }
};