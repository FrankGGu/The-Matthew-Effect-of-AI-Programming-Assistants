#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumMoney(vector<int>& transactions) {
        long long res = 0;
        for (int& t : transactions) {
            res += t;
        }
        sort(transactions.begin(), transactions.end());
        for (int i = 0; i < transactions.size(); ++i) {
            if (i == transactions.size() - 1) {
                res -= transactions[i];
            } else {
                res -= transactions[i] / 2;
            }
        }
        return res;
    }
};