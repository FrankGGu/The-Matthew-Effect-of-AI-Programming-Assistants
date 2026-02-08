#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int splitArray(vector<int>& nums, int k) {
        int left = 0, right = 0;
        for (int num : nums) {
            left = max(left, num);
            right += num;
        }

        while (left < right) {
            int mid = left + (right - left) / 2;
            int count = 1, sum = 0;
            for (int num : nums) {
                if (sum + num > mid) {
                    count++;
                    sum = num;
                } else {
                    sum += num;
                }
            }

            if (count > k) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return left;
    }
};