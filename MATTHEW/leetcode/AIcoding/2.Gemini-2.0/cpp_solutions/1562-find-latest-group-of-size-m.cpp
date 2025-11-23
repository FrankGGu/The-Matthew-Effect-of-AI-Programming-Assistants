#include <vector>

using namespace std;

class Solution {
public:
    int findLatestStep(vector<int>& arr, int m) {
        int n = arr.size();
        if (m == n) return n;
        vector<int> length(n + 2, 0);
        vector<int> count(n + 1, 0);
        int ans = -1;

        for (int i = 0; i < n; ++i) {
            int a = arr[i];
            int left = length[a - 1];
            int right = length[a + 1];
            length[a - left] = length[a + right] = left + right + 1;
            length[a] = 1;

            if (left > 0) count[left]--;
            if (right > 0) count[right]--;
            count[left + right + 1]++;

            if (count[m] > 0) ans = i + 1;
        }

        return ans;
    }
};