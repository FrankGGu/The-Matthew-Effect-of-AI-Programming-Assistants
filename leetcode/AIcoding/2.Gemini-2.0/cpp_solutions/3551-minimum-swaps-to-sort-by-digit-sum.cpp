#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSwaps(vector<int>& nums) {
        int n = nums.size();
        vector<pair<int, int>> arr(n);
        for (int i = 0; i < n; ++i) {
            int sum = 0;
            int temp = nums[i];
            while (temp > 0) {
                sum += temp % 10;
                temp /= 10;
            }
            arr[i] = {sum, i};
        }

        sort(arr.begin(), arr.end());

        int ans = 0;
        vector<bool> visited(n, false);

        for (int i = 0; i < n; ++i) {
            if (visited[i] || arr[i].second == i) continue;

            int cycle_size = 0;
            int j = i;
            while (!visited[j]) {
                visited[j] = true;
                j = arr[j].second;
                cycle_size++;
            }

            ans += (cycle_size - 1);
        }

        return ans;
    }
};