#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> A;
    int index;

    Solution(vector<int> &nums) {
        A = nums;
        index = 0;
    }

    int next(int n) {
        while (n > 0 && index < A.size()) {
            int count = A[index];
            int value = A[index + 1];
            if (count <= n) {
                n -= count;
                index += 2;
            } else {
                A[index] -= n;
                n = 0;
                return value;
            }
        }
        return -1;
    }
};