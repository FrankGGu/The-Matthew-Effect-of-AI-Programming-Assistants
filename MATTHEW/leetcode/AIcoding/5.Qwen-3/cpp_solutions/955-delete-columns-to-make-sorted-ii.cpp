#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minDeletionSize(vector<string>& strs) {
        int n = strs.size();
        int m = strs[0].size();
        int count = 0;
        vector<char> prev(m, 'a');

        for (int j = 0; j < m; ++j) {
            for (int i = 0; i < n; ++i) {
                if (strs[i][j] < prev[j]) {
                    count++;
                    break;
                }
            }
            for (int i = 0; i < n; ++i) {
                prev[j] = strs[i][j];
            }
        }
        return count;
    }
};