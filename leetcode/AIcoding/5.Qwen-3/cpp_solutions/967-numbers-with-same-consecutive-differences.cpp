#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> numsSameConsecDiff(int n, int k) {
        vector<int> result;
        queue<int> q;

        for (int i = 1; i <= 9; ++i) {
            q.push(i);
        }

        while (!q.empty()) {
            int num = q.front();
            q.pop();

            if (n == 1) {
                result.push_back(num);
                continue;
            }

            int lastDigit = num % 10;
            int nextDigit1 = lastDigit + k;
            int nextDigit2 = lastDigit - k;

            if (nextDigit1 <= 9) {
                q.push(num * 10 + nextDigit1);
            }
            if (nextDigit2 >= 0 && nextDigit1 != nextDigit2) {
                q.push(num * 10 + nextDigit2);
            }
        }

        return result;
    }
};