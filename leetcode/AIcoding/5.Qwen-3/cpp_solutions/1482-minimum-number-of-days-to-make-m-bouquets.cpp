#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minDays(vector<int>& bloomDay, int m, int n) {
        if (m * n > bloomDay.size()) return -1;

        int left = 1, right = *max_element(bloomDay.begin(), bloomDay.end());

        while (left < right) {
            int mid = left + (right - left) / 2;
            int count = 0;
            int consecutive = 0;

            for (int day : bloomDay) {
                if (day <= mid) {
                    consecutive++;
                    if (consecutive == n) {
                        count++;
                        consecutive = 0;
                    }
                } else {
                    consecutive = 0;
                }
            }

            if (count >= m) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        return left;
    }
};