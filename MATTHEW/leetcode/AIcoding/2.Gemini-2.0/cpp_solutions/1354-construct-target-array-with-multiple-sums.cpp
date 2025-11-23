#include <vector>
#include <queue>
#include <numeric>

using namespace std;

class Solution {
public:
    bool isPossible(vector<int>& target) {
        long long sum = accumulate(target.begin(), target.end(), 0LL);
        priority_queue<int> pq(target.begin(), target.end());

        while (true) {
            int largest = pq.top();
            pq.pop();

            long long restSum = sum - largest;

            if (largest == 1 || restSum == 1) {
                return true;
            }

            if (largest < restSum || restSum == 0) {
                return false;
            }

            int prevNum = largest % (int)restSum;

            if (prevNum == 0) {
                return false;
            }

            pq.push(prevNum);
            sum = restSum + prevNum;
        }
    }
};