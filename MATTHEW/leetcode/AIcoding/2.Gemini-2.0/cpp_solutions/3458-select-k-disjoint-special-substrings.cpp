#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxHappyGroups(int n, vector<int>& groupSizes, int k) {
        vector<int> counts(k, 0);
        int happy = 0;
        for (int size : groupSizes) {
            int rem = size % k;
            if (rem == 0) {
                happy++;
            } else {
                counts[rem]++;
            }
        }

        for (int i = 1; i <= k / 2; ++i) {
            if (i == k - i && k % 2 == 0) {
                happy += counts[i] / 2;
                counts[i] %= 2;
            } else {
                int mn = min(counts[i], counts[k - i]);
                happy += mn;
                counts[i] -= mn;
                counts[k - i] -= mn;
            }
        }

        int remaining = 0;
        for (int i = 1; i < k; ++i) {
            remaining += counts[i];
        }

        if (remaining > 0) {
            vector<int> dp(1 << (k - 1), 0);
            dp[0] = 0;

            for (int mask = 0; mask < (1 << (k - 1)); ++mask) {
                if (dp[mask] == -1) continue;
                for (int i = 0; i < k - 1; ++i) {
                    if (counts[i + 1] > 0 && !(mask & (1 << i))) {
                        int newMask = mask | (1 << i);
                        int sum = 0;
                        for(int j = 0; j < k - 1; j++){
                            if(newMask & (1 << j)){
                                sum += j + 1;
                            }
                        }
                        if(sum % k == 0){
                            dp[newMask] = max(dp[newMask], dp[mask] + 1);
                        } else {
                             dp[newMask] = max(dp[newMask], dp[mask]);
                        }
                    }
                }
            }

            int curSum = 0;
            for(int i = 1; i < k; i++){
                curSum += counts[i];
            }

            int mask = 0;
            for(int i = 1; i < k; i++){
                if(counts[i] > 0){
                    mask = (1 << (i - 1));
                } else {
                    mask = 0;
                }
            }

            vector<int> groupSizes2;
            for(int i = 1; i < k; i++){
                for(int j = 0; j < counts[i]; j++){
                    groupSizes2.push_back(i);
                }
            }

            if(groupSizes2.size() == 0) {
                return happy;
            }

            int max_happy = 0;
             vector<int> dp2(1 << groupSizes2.size(), 0);
            for (int i = 1; i < (1 << groupSizes2.size()); ++i) {
                int sum = 0;
                for (int j = 0; j < groupSizes2.size(); ++j) {
                    if ((i >> j) & 1) {
                        sum += groupSizes2[j];
                    }
                }
                if (sum % k == 0) {
                   int count = 0;
                   for(int j = 0; j < groupSizes2.size(); j++){
                       if((i >> j) & 1){
                           count++;
                       }
                   }
                   max_happy = max(max_happy, count);
                }
            }

            return happy + max_happy;

        }

        return happy;
    }
};