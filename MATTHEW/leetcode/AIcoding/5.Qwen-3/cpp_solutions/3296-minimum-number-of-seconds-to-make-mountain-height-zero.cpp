#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minimumSecondsToMakeMountainHeightZero(vector<int>& height) {
        int n = height.size();
        vector<int> left(n, 0), right(n, 0);
        vector<int> time(n, 0);

        for (int i = 1; i < n; ++i) {
            if (height[i] > height[i - 1]) {
                left[i] = left[i - 1] + 1;
            } else {
                left[i] = 0;
            }
        }

        for (int i = n - 2; i >= 0; --i) {
            if (height[i] > height[i + 1]) {
                right[i] = right[i + 1] + 1;
            } else {
                right[i] = 0;
            }
        }

        for (int i = 0; i < n; ++i) {
            time[i] = max(left[i], right[i]);
        }

        return *max_element(time.begin(), time.end());
    }
};