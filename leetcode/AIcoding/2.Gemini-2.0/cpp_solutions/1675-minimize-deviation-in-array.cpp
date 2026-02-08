#include <vector>
#include <set>
#include <algorithm>

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

        int min_deviation = *s.rbegin() - *s.begin();

        while (*s.rbegin() % 2 == 0) {
            int max_val = *s.rbegin();
            s.erase(max_val);
            s.insert(max_val / 2);
            min_deviation = min(min_deviation, *s.rbegin() - *s.begin());
        }

        return min_deviation;
    }
};