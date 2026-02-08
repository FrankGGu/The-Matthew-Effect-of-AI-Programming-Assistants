#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<vector<int>> largeGroupPositions(string s) {
        vector<vector<int>> result;
        int n = s.length();
        int start = 0;

        for (int i = 1; i < n; ++i) {
            if (s[i] != s[i - 1]) {
                if (i - start >= 3) {
                    result.push_back({start, i - 1});
                }
                start = i;
            }
        }

        if (n - start >= 3) {
            result.push_back({start, n - 1});
        }

        return result;
    }
};