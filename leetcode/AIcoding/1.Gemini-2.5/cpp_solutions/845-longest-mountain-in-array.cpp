#include <vector>
#include <algorithm>

class Solution {
public:
    int longestMountain(std::vector<int>& arr) {
        int n = arr.size();
        if (n < 3) {
            return 0;
        }

        int maxLength = 0;
        int i = 0;

        while (i < n) {
            int base = i;

            if (i + 1 < n && arr[i] < arr[i + 1]) {
                while (i + 1 < n && arr[i] < arr[i + 1]) {
                    i++;
                }

                if (i + 1 < n && arr[i] > arr[i + 1]) {
                    while (i + 1 < n && arr[i] > arr[i + 1]) {
                        i++;
                    }
                    maxLength = std::max(maxLength, i - base + 1);
                }
            }

            if (i == base) {
                i++;
            }
        }

        return maxLength;
    }
};