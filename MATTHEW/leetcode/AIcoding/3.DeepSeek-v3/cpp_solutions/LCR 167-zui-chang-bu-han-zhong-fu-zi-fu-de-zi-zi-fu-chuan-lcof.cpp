#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int dismantlingAction(string arr) {
        vector<int> index(128, -1);
        int max_len = 0;
        int left = 0;
        for (int right = 0; right < arr.size(); ++right) {
            if (index[arr[right]] != -1) {
                left = max(left, index[arr[right]] + 1);
            }
            index[arr[right]] = right;
            max_len = max(max_len, right - left + 1);
        }
        return max_len;
    }
};