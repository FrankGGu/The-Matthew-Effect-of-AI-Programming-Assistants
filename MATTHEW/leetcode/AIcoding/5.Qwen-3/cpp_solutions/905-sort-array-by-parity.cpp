#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> sortArrayByParity(vector<int>& A) {
        int left = 0, right = A.size() - 1;
        while (left < right) {
            if (A[left] % 2 == 1 && A[right] % 2 == 0) {
                swap(A[left], A[right]);
                left++;
                right--;
            } else if (A[left] % 2 == 0) {
                left++;
            } else if (A[right] % 2 == 1) {
                right--;
            }
        }
        return A;
    }
};