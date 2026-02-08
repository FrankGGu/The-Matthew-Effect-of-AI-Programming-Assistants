#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string minInteger(string num, int k) {
        int n = num.length();
        vector<int> pos(n);
        for (int i = 0; i < n; ++i) {
            pos[i] = i;
        }

        for (int i = 0; i < n && k > 0; ++i) {
            int min_idx = i;
            for (int j = i + 1; j < n && j - i <= k; ++j) {
                if (num[pos[j]] < num[pos[min_idx]]) {
                    min_idx = j;
                }
            }
            if (min_idx != i) {
                k -= (min_idx - i);
                swap(pos[i], pos[min_idx]);
                for (int j = min_idx; j > i; --j) {
                    swap(pos[j], pos[j - 1]);
                }
            }
        }

        string result;
        for (int i = 0; i < n; ++i) {
            result += num[pos[i]];
        }
        return result;
    }
};