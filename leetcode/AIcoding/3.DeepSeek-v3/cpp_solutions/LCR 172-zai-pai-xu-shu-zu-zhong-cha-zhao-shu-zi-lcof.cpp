#include <vector>
using namespace std;

class Solution {
public:
    int countTarget(vector<int>& scores, int target) {
        int n = scores.size();
        if (n == 0) return 0;

        int left = 0, right = n;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (scores[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        int lower_bound = left;

        left = 0;
        right = n;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (scores[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        int upper_bound = left;

        return upper_bound - lower_bound;
    }
};