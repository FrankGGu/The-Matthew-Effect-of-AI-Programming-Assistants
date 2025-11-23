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

        for (int i = 1; i < n; ++i) {
            int size = q.size();
            for (int j = 0; j < size; ++j) {
                int num = q.front();
                q.pop();
                int lastDigit = num % 10;

                if (lastDigit + k <= 9) {
                    q.push(num * 10 + (lastDigit + k));
                }
                if (k != 0 && lastDigit - k >= 0) {
                    q.push(num * 10 + (lastDigit - k));
                }
            }
        }

        while (!q.empty()) {
            result.push_back(q.front());
            q.pop();
        }

        return result;
    }
};