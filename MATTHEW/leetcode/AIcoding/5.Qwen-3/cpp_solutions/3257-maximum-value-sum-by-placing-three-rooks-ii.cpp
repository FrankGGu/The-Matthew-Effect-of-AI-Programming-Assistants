#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    long long maximumValueSum(vector<int>& a, vector<int>& b, vector<int>& c) {
        vector<int> row = a;
        vector<int> col = b;
        vector<int> diag = c;

        sort(row.begin(), row.end());
        sort(col.begin(), row.end());
        sort(diag.begin(), diag.end());

        int n = a.size();
        long long maxSum = 0;

        for (int i = 0; i < n; ++i) {
            if (i < row.size()) maxSum += row[i];
            if (i < col.size()) maxSum += col[i];
            if (i < diag.size()) maxSum += diag[i];
        }

        return maxSum;
    }
};