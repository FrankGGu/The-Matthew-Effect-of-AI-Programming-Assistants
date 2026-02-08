#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> advantageCount(vector<int>& A, vector<int>& B) {
        int n = A.size();
        vector<int> ans(n);
        vector<pair<int, int>> b_indexed(n);
        for (int i = 0; i < n; ++i) {
            b_indexed[i] = {B[i], i};
        }
        sort(A.begin(), A.end());
        sort(b_indexed.begin(), b_indexed.end());

        int left = 0, right = n - 1;
        for (int i = 0; i < n; ++i) {
            if (A[i] > b_indexed[left].first) {
                ans[b_indexed[left].second] = A[i];
                left++;
            } else {
                ans[b_indexed[right].second] = A[i];
                right--;
            }
        }
        return ans;
    }
};