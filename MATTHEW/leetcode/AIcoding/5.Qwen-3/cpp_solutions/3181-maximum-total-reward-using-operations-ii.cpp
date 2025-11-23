#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int maximumTotalReward(vector<int>& arr) {
        sort(arr.begin(), arr.end());
        unordered_set<int> s;
        for (int num : arr) {
            s.insert(num);
        }
        vector<int> sortedArr(arr.begin(), arr.end());
        int n = sortedArr.size();
        vector<int> dp(n, 0);
        for (int i = 0; i < n; ++i) {
            if (i == 0 || sortedArr[i] > sortedArr[i - 1]) {
                dp[i] = sortedArr[i];
            }
            for (int j = 0; j < i; ++j) {
                if (sortedArr[i] > sortedArr[j] && s.find(sortedArr[i] - sortedArr[j]) != s.end()) {
                    dp[i] = max(dp[i], dp[j] + sortedArr[i]);
                }
            }
        }
        return *max_element(dp.begin(), dp.end());
    }
};