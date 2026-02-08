#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int lenLongestFibSubseq(vector<int>& A) {
        unordered_map<int, int> index;
        int n = A.size();
        for (int i = 0; i < n; ++i) {
            index[A[i]] = i;
        }

        int maxLength = 0;
        for (int j = 1; j < n; ++j) {
            for (int i = 0; i < j; ++i) {
                int k = A[j] - A[i];
                if (k < A[i] && index.count(k)) {
                    int len = 2, x = A[i], y = A[j];
                    while (index.count(x + y)) {
                        int temp = x + y;
                        x = y;
                        y = temp;
                        ++len;
                    }
                    maxLength = max(maxLength, len);
                }
            }
        }

        return maxLength >= 3 ? maxLength : 0;
    }
};