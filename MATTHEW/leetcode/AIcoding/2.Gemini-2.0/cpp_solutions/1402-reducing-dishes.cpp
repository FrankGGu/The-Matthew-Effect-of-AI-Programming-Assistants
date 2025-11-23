#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSatisfaction(vector<int>& satisfaction) {
        sort(satisfaction.begin(), satisfaction.end());
        int n = satisfaction.size();
        int max_like_time_coeff = 0;
        int current_sum = 0;
        int total_sum = 0;

        for (int i = n - 1; i >= 0; --i) {
            current_sum += satisfaction[i];
            if (current_sum > 0) {
                total_sum += current_sum;
                max_like_time_coeff = max(max_like_time_coeff, total_sum);
            } else {
                break;
            }
        }

        return max_like_time_coeff;
    }
};