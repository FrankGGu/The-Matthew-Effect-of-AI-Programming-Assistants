#include <vector>
#include <set>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minimumDeviation(vector<int>& nums) {
        set<int> s;
        for (int num : nums) {
            if (num % 2 == 1) {
                s.insert(num * 2);
            } else {
                s.insert(num);
            }
        }

        int min_deviation = INT_MAX;
        while (true) {
            int max_val = *s.rbegin();
            int min_val = *s.begin();
            min_deviation = min(min_deviation, max_val - min_val);

            if (max_val % 2 == 0) {
                s.erase(max_val);
                s.insert(max_val / 2);
            } else {
                break;
            }
        }

        return min_deviation;
    }
};