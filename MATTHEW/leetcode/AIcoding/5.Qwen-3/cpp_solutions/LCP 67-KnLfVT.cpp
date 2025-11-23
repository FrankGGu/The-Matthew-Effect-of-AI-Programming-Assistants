#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> decorateTree(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> result(n);
        unordered_map<int, int> count;
        queue<int> q;

        for (int i = 0; i < n; ++i) {
            count[nums[i]]++;
            if (count[nums[i]] == 1) {
                q.push(nums[i]);
            }
        }

        while (!q.empty()) {
            int current = q.front();
            q.pop();
            result[current] = k;
            k--;
            if (k < 0) break;

            for (int i = 0; i < n; ++i) {
                if (nums[i] == current) {
                    for (int j = 0; j < n; ++j) {
                        if (nums[j] != current && count[nums[j]] > 0) {
                            count[nums[j]]--;
                            if (count[nums[j]] == 1) {
                                q.push(nums[j]);
                            }
                        }
                    }
                    break;
                }
            }
        }

        return result;
    }
};