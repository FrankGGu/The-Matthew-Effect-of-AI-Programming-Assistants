#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximizeHappiness(int n, int k, vector<int>& sweetness) {
        sort(sweetness.begin(), sweetness.end());
        long long left = 0, right = 1e12;
        long long ans = 0;
        while (left <= right) {
            long long mid = left + (right - left) / 2;
            int count = 0;
            long long sum = 0;
            for (int i = 0; i < sweetness.size(); i++) {
                sum += sweetness[i];
                if (sum >= mid) {
                    count++;
                    sum = 0;
                }
            }
            if (count >= k) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return ans;
    }
};