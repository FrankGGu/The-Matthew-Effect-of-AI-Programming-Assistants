#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int mostSlices(int n, vector<int>& slices) {
        int m = slices.size();
        vector<vector<int>> dp(m, vector<int>(m, 0));

        for (int i = 0; i < m; ++i) {
            dp[i][i] = slices[i];
        }

        for (int length = 2; length <= m; ++length) {
            for (int i = 0; i + length - 1 < m; ++i) {
                int j = i + length - 1;
                dp[i][j] = max(slices[i] + dp[i+2][j], slices[j] + dp[i][j-2]);
            }
        }

        return dp[0][m-1];
    }

    int mostSlices(int n, vector<int>& slices, int start, int end) {
        if (start > end) return 0;
        if (start == end) return slices[start];
        int mid = (start + end) / 2;
        int left = mostSlices(n, slices, start, mid);
        int right = mostSlices(n, slices, mid + 1, end);
        int both = slices[mid] + slices[mid + 1] + mostSlices(n, slices, start, mid - 1) + mostSlices(n, slices, mid + 2, end);
        return max(left, max(right, both));
    }

    int mostSlices(int n, vector<int>& slices) {
        int m = slices.size();
        if (m == 1) return slices[0];
        vector<int> first = slices;
        vector<int> second = slices;
        first.erase(first.begin());
        second.pop_back();
        return max(mostSlices(n, first), mostSlices(n, second));
    }
};