#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minFlipsMonoIncr(string s) {
        int n = s.size();
        vector<int> left(n, 0);
        vector<int> right(n, 0);

        for (int i = 1; i < n; ++i) {
            left[i] = left[i - 1] + (s[i - 1] == '1' ? 0 : 1);
        }

        for (int i = n - 2; i >= 0; --i) {
            right[i] = right[i + 1] + (s[i + 1] == '0' ? 0 : 1);
        }

        int result = n;
        for (int i = 0; i < n; ++i) {
            result = min(result, left[i] + right[i]);
        }

        return result;
    }
};