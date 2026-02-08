#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool canFormArray(vector<int>& arr, vector<vector<int>>& pieces) {
        int n = arr.size();
        int m = pieces.size();
        int i = 0;
        while (i < n) {
            bool found = false;
            for (int j = 0; j < m; ++j) {
                if (pieces[j][0] == arr[i]) {
                    int k = 0;
                    while (k < pieces[j].size() && i < n && pieces[j][k] == arr[i]) {
                        ++i;
                        ++k;
                    }
                    if (k == pieces[j].size()) {
                        found = true;
                    } else {
                        return false;
                    }
                }
            }
            if (!found) {
                return false;
            }
        }
        return true;
    }
};