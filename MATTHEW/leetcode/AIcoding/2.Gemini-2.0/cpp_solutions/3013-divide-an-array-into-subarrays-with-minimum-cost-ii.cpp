#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

long long minCost(vector<int>& nums, int k, int dist) {
    int n = nums.size();
    long long ans = -1;

    for (int i = 0; i <= n - dist - 1; ++i) {
        priority_queue<int> left;
        priority_queue<int, vector<int>, greater<int>> right;
        long long current_cost = nums[0];
        int left_count = k - 1;
        int right_count = dist - (k - 1);

        for (int j = 1; j <= dist + 1; ++j) {
            if (j <= i) continue;
            if (left_count > 0) {
                left.push(nums[j]);
                current_cost += nums[j];
                left_count--;
            } else {
                right.push(nums[j]);
            }
        }

        while (left.size() > k - 1) {
            int val = left.top();
            left.pop();
            current_cost -= val;
            right.push(val);
        }

        while (right.size() > dist - (k - 1)) {
            int val = right.top();
            right.pop();
            left.push(val);
            current_cost += val;
        }

        ans = (ans == -1) ? current_cost : min(ans, current_cost);

        for (int j = i + 1; j <= n - dist - 1; ++j) {
            int removed_val = nums[j];
            int added_val = nums[j + dist];

            bool removed_from_left = false;
            bool added_to_left = false;

            priority_queue<int> temp_left = left;
            bool found_in_left = false;
            long long temp_cost = current_cost;

            priority_queue<int, vector<int>, greater<int>> temp_right = right;

            vector<int> left_vals, right_vals;

            while(!temp_left.empty()){
                left_vals.push_back(temp_left.top());
                temp_left.pop();
            }

            while(!temp_right.empty()){
                right_vals.push_back(temp_right.top());
                temp_right.pop();
            }

            if (find(left_vals.begin(), left_vals.end(), removed_val) != left_vals.end()) {
                removed_from_left = true;
                current_cost -= removed_val;
            } else {

            }

            if (!right.empty() && added_val < right.top()) {
                added_to_left = true;
                current_cost += added_val;
            }

            if (removed_from_left) {
                if (!right.empty()) {
                  int val = right.top();
                  right.pop();
                  left.push(val);
                  current_cost += val;
                }
            }

            if (added_to_left) {
                left.push(added_val);
            } else {
                right.push(added_val);
            }

            while (left.size() > k - 1) {
                int val = left.top();
                left.pop();
                current_cost -= val;
                right.push(val);
            }

            while (right.size() > dist - (k - 1)) {
                int val = right.top();
                right.pop();
                left.push(val);
                current_cost += val;
            }

            ans = min(ans, current_cost);
        }
    }

    return ans;
}