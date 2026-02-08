#include <vector>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    int lenLongestFibSubseq(std::vector<int>& arr) {
        std::unordered_set<int> s(arr.begin(), arr.end());
        int n = arr.size();
        int ans = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                long long a = arr[i];
                long long b = arr[j];
                int length = 2;
                while (s.count(a + b)) {
                    long long next = a + b;
                    a = b;
                    b = next;
                    length++;
                }
                if (length > 2) {
                    ans = std::max(ans, length);
                }
            }
        }
        return ans;
    }
};