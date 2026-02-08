#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> threeEqualParts(int* A, int ASize) {
        vector<int> result;
        int totalOnes = 0;
        for (int i = 0; i < ASize; ++i) {
            if (A[i] == 1) {
                totalOnes++;
            }
        }

        if (totalOnes % 3 != 0) {
            return {-1, -1};
        }

        if (totalOnes == 0) {
            return {0, 2};
        }

        int partSize = totalOnes / 3;
        int first = 0, second = 0, third = 0;
        int count = 0;

        for (int i = 0; i < ASize; ++i) {
            if (A[i] == 1) {
                count++;
                if (count == partSize) {
                    first = i;
                } else if (count == 2 * partSize) {
                    second = i;
                } else if (count == 3 * partSize) {
                    third = i;
                    break;
                }
            }
        }

        int len = ASize - third;
        if (first + len > second || second + len > third) {
            return {-1, -1};
        }

        for (int i = 0; i < len; ++i) {
            if (A[first + i] != A[second + i] || A[first + i] != A[third + i]) {
                return {-1, -1};
            }
        }

        return {first + len, second + len};
    }
};