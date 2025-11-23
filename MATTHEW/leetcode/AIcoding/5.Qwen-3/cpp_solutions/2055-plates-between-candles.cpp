#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int platesBetweenCandles(int n, vector<int>& days, vector<vector<int>>& queries) {
        vector<int> prefix(n, 0);
        vector<int> left(n, -1);
        vector<int> right(n, -1);

        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (days[i] == 1) {
                count++;
            }
            prefix[i] = count;
        }

        int last = -1;
        for (int i = 0; i < n; ++i) {
            if (days[i] == 1) {
                last = i;
            }
            left[i] = last;
        }

        last = -1;
        for (int i = n - 1; i >= 0; --i) {
            if (days[i] == 1) {
                last = i;
            }
            right[i] = last;
        }

        int result = 0;
        for (auto& q : queries) {
            int l = q[0];
            int r = q[1];
            int first = right[l];
            int last_candle = left[r];
            if (first == -1 || last_candle == -1 || first > last_candle) {
                continue;
            }
            result += prefix[last_candle] - prefix[first];
        }

        return result;
    }
};