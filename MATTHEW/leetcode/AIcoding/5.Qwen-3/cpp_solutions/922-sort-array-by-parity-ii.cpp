#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> sortArrayByParityII(vector<int>& A) {
        int n = A.size();
        int i = 0, j = 1;
        while (i < n && j < n) {
            if (A[i] % 2 == 0) {
                i += 2;
            } else if (A[j] % 2 == 1) {
                j += 2;
            } else {
                swap(A[i], A[j]);
            }
        }
        return A;
    }
};