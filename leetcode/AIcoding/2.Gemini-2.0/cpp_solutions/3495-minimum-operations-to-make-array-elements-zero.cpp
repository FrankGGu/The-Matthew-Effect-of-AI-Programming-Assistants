#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        int count = 0;
        vector<int> non_zero;
        for (int num : nums) {
            if (num > 0) {
                non_zero.push_back(num);
            }
        }

        sort(non_zero.begin(), non_zero.end());

        while (!non_zero.empty()) {
            int min_val = non_zero[0];
            count++;
            vector<int> next_non_zero;
            for (int num : non_zero) {
                int diff = num - min_val;
                if (diff > 0) {
                    next_non_zero.push_back(diff);
                }
            }

            sort(next_non_zero.begin(), next_non_zero.end());
            non_zero = next_non_zero;
        }

        return count;
    }
};