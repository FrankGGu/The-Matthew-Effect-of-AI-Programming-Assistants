#include <vector>
#include <numeric>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> fairCandySwap(vector<int>& A, vector<int>& B) {
        int sumA = accumulate(A.begin(), A.end(), 0);
        int sumB = accumulate(B.begin(), B.end(), 0);
        int diff = (sumB - sumA) / 2;
        unordered_set<int> setB(B.begin(), B.end());

        for (int a : A) {
            if (setB.count(a + diff)) {
                return {a, a + diff};
            }
        }

        return {};
    }
};