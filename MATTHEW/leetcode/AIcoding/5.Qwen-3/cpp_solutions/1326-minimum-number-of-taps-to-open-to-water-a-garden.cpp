#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minTaps(int n) {
        vector<int> arr(n + 1, 0);
        for (int i = 0; i <= n; ++i) {
            int left = max(0, i - arr[i]);
            int right = min(n, i + arr[i]);
            arr[left] = max(arr[left], right);
        }

        int res = 0;
        int end = 0;
        int next_end = 0;
        for (int i = 0; i <= n; ++i) {
            if (i > end) {
                return -1;
            }
            next_end = max(next_end, arr[i]);
            if (i == end) {
                res++;
                end = next_end;
            }
        }
        return res;
    }
};