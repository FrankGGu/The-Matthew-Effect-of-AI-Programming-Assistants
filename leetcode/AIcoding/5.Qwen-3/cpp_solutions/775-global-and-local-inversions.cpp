#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool isIdealWeight(vector<int>& A) {
        for (int i = 0; i < A.size(); ++i) {
            if (abs(A[i] - i) > 1) {
                return false;
            }
        }
        return true;
    }
};