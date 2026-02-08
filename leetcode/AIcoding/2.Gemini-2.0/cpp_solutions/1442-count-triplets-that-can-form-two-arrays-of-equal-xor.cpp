#include <vector>

using namespace std;

class Solution {
public:
    int countTriplets(vector<int>& arr) {
        int n = arr.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                for (int k = j; k < n; ++k) {
                    int a = 0;
                    for (int l = i; l < j; ++l) {
                        a ^= arr[l];
                    }
                    int b = 0;
                    for (int l = j; l <= k; ++l) {
                        b ^= arr[l];
                    }
                    if (a == b) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
};