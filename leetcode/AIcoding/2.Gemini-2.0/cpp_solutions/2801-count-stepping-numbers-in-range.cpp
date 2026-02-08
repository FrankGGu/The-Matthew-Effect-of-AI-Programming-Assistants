#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int countSteppingNumbers(int low, int high) {
        int count = 0;
        vector<int> nums = bfs(high);
        for (int num : nums) {
            if (num >= low && num <= high) {
                count++;
            }
        }
        return count;
    }

private:
    vector<int> bfs(int high) {
        vector<int> res;
        queue<long long> q;
        for (int i = 0; i <= 9; ++i) {
            q.push(i);
        }

        while (!q.empty()) {
            long long num = q.front();
            q.pop();

            if (num > high) continue;

            if (num > 0) {
                res.push_back(num);
            }

            int lastDigit = num % 10;
            if (lastDigit > 0) {
                long long nextNum = num * 10 + (lastDigit - 1);
                if (nextNum <= high) {
                    q.push(nextNum);
                }
            }
            if (lastDigit < 9) {
                long long nextNum = num * 10 + (lastDigit + 1);
                if (nextNum <= high) {
                    q.push(nextNum);
                }
            }
        }

        sort(res.begin(), res.end());
        return res;
    }
};