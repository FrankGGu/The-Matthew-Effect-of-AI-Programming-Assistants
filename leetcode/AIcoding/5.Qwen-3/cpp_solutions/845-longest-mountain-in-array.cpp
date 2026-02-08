#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int longestMountain(vector<int>& arr) {
        int n = arr.size();
        if (n < 3) return 0;

        int maxLen = 0;
        int i = 1;

        while (i < n - 1) {
            int up = 0, down = 0;

                        while (i < n - 1 && arr[i] > arr[i - 1]) {
                up++;
                i++;
            }

                        while (i < n - 1 && arr[i] < arr[i - 1]) {
                down++;
                i++;
            }

            if (up > 0 && down > 0) {
                maxLen = max(maxLen, up + down + 1);
            } else {
                i++;
            }
        }

        return maxLen;
    }
};