#include <vector>

using namespace std;

class Solution {
public:
    vector<long long> getFinalState(int n, int k, vector<long long>& arr, vector<vector<int>>& queries) {
        vector<long long> temp = arr;
        for (int i = 0; i < k; ++i) {
            int l = queries[i][0];
            int r = queries[i][1];
            int x = queries[i][2];
            for (int j = l; j <= r; ++j) {
                temp[j] *= x;
            }
        }
        return temp;
    }
};