#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    double minimumAverage(vector<int>& nums) {
        int n = nums.size();
        double min_avg = -1.0;

        for (int i = 0; i < n - 1; ++i) {
            for (int j = i + 1; j < n; ++j) {
                vector<int> sub_array;
                for (int k = i; k <= j; ++k) {
                    sub_array.push_back(nums[k]);
                }

                int min_val = *min_element(sub_array.begin(), sub_array.end());
                int max_val = *max_element(sub_array.begin(), sub_array.end());

                double avg = (double)(min_val + max_val) / 2.0;

                if (min_avg == -1.0 || avg < min_avg) {
                    min_avg = avg;
                }
            }
        }

        return min_avg;
    }
};