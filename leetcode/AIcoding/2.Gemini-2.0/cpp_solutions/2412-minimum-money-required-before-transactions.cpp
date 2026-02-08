#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumMoney(vector<vector<int>>& transactions) {
        long long loss = 0;
        vector<int> gains;
        for (auto& t : transactions) {
            if (t[0] > t[1]) {
                loss += t[0] - t[1];
                gains.push_back(t[0]);
            } else {
                gains.push_back(t[1]);
            }
        }
        sort(gains.rbegin(), gains.rend());
        if (gains.empty()) return 0;
        return loss + gains[0];
    }
};