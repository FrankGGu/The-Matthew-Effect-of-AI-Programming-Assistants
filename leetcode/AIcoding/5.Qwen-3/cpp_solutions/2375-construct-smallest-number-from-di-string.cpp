#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string minNumber(string pattern) {
        vector<int> result;
        int n = pattern.size();
        vector<bool> used(n + 1, false);

        for (int i = 0; i <= n; ++i) {
            result.push_back(i);
        }

        for (int i = 0; i < n; ++i) {
            if (pattern[i] == 'D') {
                int j = i;
                while (j >= 0 && pattern[j] == 'D') {
                    --j;
                }
                reverse(result.begin() + j + 1, result.begin() + i + 1);
                i = j;
            }
        }

        string res;
        for (int num : result) {
            res += to_string(num);
        }
        return res;
    }
};