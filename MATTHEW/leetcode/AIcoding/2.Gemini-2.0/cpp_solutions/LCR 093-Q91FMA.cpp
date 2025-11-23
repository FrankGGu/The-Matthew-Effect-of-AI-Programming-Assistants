#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int lenLongestFibSubseq(vector<int>& arr) {
        int n = arr.size();
        unordered_set<int> s(arr.begin(), arr.end());
        int ans = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int a = arr[i];
                int b = arr[j];
                int len = 2;

                while (s.count(a + b)) {
                    int temp = b;
                    b = a + b;
                    a = temp;
                    len++;
                }

                ans = max(ans, len);
            }
        }

        return ans > 2 ? ans : 0;
    }
};