#include <vector>

using namespace std;

class Solution {
public:
    int securityCheck(vector<int>& weights, int capacity) {
        int low = 1, high = 100000;
        int ans = 100000;
        while (low <= high) {
            int mid = (low + high) / 2;
            int days = 1;
            int currentWeight = 0;
            bool possible = true;
            for (int weight : weights) {
                if (weight > capacity) {
                    possible = false;
                    break;
                }
                if (currentWeight + weight <= capacity) {
                    currentWeight += weight;
                } else {
                    days++;
                    currentWeight = weight;
                }
            }
            if (!possible) {
                low = mid + 1;
                continue;
            }

            if (days <= mid) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }
};