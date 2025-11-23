#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int numberOfArrays(vector<int>& differences, int lower, int upper) {
        long long min_val = 0, max_val = 0;
        long long current = 0;
        for (int diff : differences) {
            current += diff;
            min_val = min(min_val, current);
            max_val = max(max_val, current);
        }
        long long lower_bound = lower - min_val;
        long long upper_bound = upper - max_val;
        if (lower_bound > upper_bound) {
            return 0;
        }
        return upper_bound - lower_bound + 1;
    }
};