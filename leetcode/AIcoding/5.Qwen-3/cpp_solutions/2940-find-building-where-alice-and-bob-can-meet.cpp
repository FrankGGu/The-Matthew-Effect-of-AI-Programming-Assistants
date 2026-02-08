#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findBuilding(vector<int>& A, vector<int>& B) {
        unordered_map<int, int> mapA;
        for (int i = 0; i < A.size(); ++i) {
            if (mapA.find(A[i]) == mapA.end()) {
                mapA[A[i]] = i;
            }
        }

        for (int i = 0; i < B.size(); ++i) {
            if (mapA.find(B[i]) != mapA.end()) {
                return mapA[B[i]];
            }
        }

        return -1;
    }
};