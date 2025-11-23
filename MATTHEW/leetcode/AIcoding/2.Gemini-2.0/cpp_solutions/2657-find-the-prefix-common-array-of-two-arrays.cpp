#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> findThePrefixCommonArray(vector<int>& A, vector<int>& B) {
        int n = A.size();
        vector<int> result(n);
        unordered_set<int> set_a;
        unordered_set<int> set_b;
        int common = 0;
        for (int i = 0; i < n; ++i) {
            set_a.insert(A[i]);
            set_b.insert(B[i]);
            common = 0;
            for (int j = 1; j <= n; ++j) {
                if (set_a.count(j) && set_b.count(j)) {
                    common++;
                }
            }
            result[i] = common;
        }
        return result;
    }
};