#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>
#include <stack>

using namespace std;

class Solution {
public:
    long long maximumElegance(vector<int>& nums, int k) {
        int n = nums.size();
        vector<pair<int, int>> freq;
        for (int i = 0; i < n; ++i) {
            freq.push_back({nums[i], i});
        }
        sort(freq.begin(), freq.end());

        vector<int> selected;
        vector<int> count(101, 0);
        long long elegance = 0;
        stack<int> extra;

        for (int i = 0; i < n && selected.size() < k; ++i) {
            int num = freq[i].first;
            if (count[num] == 0) {
                elegance += 1;
            }
            count[num]++;
            selected.push_back(num);
        }

        for (int i = k; i < n; ++i) {
            int num = freq[i].first;
            if (count[num] > 0) {
                extra.push(num);
            }
        }

        for (int i = 0; i < k && !extra.empty(); ++i) {
            int current = selected[i];
            if (count[current] > 1) {
                int replace = extra.top();
                extra.pop();
                if (count[replace] == 0) {
                    elegance += 1;
                }
                count[current]--;
                count[replace]++;
                selected[i] = replace;
            }
        }

        return elegance;
    }
};