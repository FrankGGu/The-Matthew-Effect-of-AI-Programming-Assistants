#include <vector>

using namespace std;

class Solution {
public:
    int minKBitFlips(vector<int>& A, int K) {
        int n = A.size();
        int ans = 0;
        vector<int> flip(n, 0);
        int cur = 0;
        for (int i = 0; i < n; ++i) {
            if ((A[i] + cur) % 2 == 0) {
                if (i + K > n) return -1;
                ans++;
                flip[i]++;
                cur++;
            }
            if (i - K + 1 >= 0) {
                cur -= flip[i - K + 1];
            }
        }
        return ans;
    }
};