#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numOfSubarrays(vector<int>& arr, int k, int threshold) {
        int n = arr.size();
        int sum = 0;
        for (int i = 0; i < k; ++i) {
            sum += arr[i];
        }
        int count = 0;
        if (sum / k >= threshold) {
            ++count;
        }
        for (int i = k; i < n; ++i) {
            sum += arr[i] - arr[i - k];
            if (sum / k >= threshold) {
                ++count;
            }
        }
        return count;
    }
};