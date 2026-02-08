#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int shipWithinDays(vector<int>& weights, int days) {
        int left = *max_element(weights.begin(), weights.end());
        int right = accumulate(weights.begin(), weights.end(), 0);

        while (left < right) {
            int mid = left + (right - left) / 2;
            int count = 1;
            int current = 0;

            for (int weight : weights) {
                if (current + weight > mid) {
                    count++;
                    current = 0;
                }
                current += weight;
            }

            if (count > days) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return left;
    }
};