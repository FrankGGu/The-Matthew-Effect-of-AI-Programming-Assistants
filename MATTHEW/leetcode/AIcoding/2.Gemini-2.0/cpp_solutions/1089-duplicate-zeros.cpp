#include <vector>

using namespace std;

class Solution {
public:
    void duplicateZeros(vector<int>& arr) {
        int n = arr.size();
        vector<int> res;
        for (int i = 0; i < n; ++i) {
            if (arr[i] == 0) {
                res.push_back(0);
                res.push_back(0);
            } else {
                res.push_back(arr[i]);
            }
        }

        arr.clear();
        for (int i = 0; i < n; ++i) {
            arr.push_back(res[i]);
        }
    }
};