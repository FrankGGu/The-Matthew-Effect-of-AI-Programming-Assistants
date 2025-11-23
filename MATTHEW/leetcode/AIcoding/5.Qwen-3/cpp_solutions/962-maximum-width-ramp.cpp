#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxWidthRamp(vector<int>& A) {
        int n = A.size();
        vector<int> indices(n);
        for (int i = 0; i < n; ++i) {
            indices[i] = i;
        }

        sort(indices.begin(), indices.end(), [&](int i, int j) {
            return A[i] < A[j] || (A[i] == A[j] && i < j);
        });

        int minIndex = n;
        int maxWidth = 0;

        for (int i = 0; i < n; ++i) {
            minIndex = min(minIndex, indices[i]);
            maxWidth = max(maxWidth, indices[i] - minIndex);
        }

        return maxWidth;
    }
};