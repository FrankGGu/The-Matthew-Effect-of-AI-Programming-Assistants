#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int kIncreasing(vector<int>& arr, int k) {
        int n = arr.size();
        int ans = 0;
        for (int i = 0; i < k; ++i) {
            vector<int> sub;
            for (int j = i; j < n; j += k) {
                sub.push_back(arr[j]);
            }
            ans += sub.size() - lengthOfLIS(sub);
        }
        return ans;
    }

private:
    int lengthOfLIS(vector<int>& nums) {
        vector<int> tail;
        for (int num : nums) {
            if (tail.empty() || num >= tail.back()) {
                tail.push_back(num);
            } else {
                auto it = upper_bound(tail.begin(), tail.end(), num);
                *it = num;
            }
        }
        return tail.size();
    }
};