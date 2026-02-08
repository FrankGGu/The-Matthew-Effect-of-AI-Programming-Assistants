#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minimumDeletions(string s) {
        int n = s.size();
        vector<int> left(n + 1, 0);
        vector<int> right(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            left[i + 1] = left[i] + (s[i] == 'b' ? 1 : 0);
        }

        for (int i = n - 1; i >= 0; --i) {
            right[i] = right[i + 1] + (s[i] == 'a' ? 1 : 0);
        }

        int result = n;
        for (int i = 0; i <= n; ++i) {
            result = min(result, left[i] + right[i]);
        }

        return result;
    }
};