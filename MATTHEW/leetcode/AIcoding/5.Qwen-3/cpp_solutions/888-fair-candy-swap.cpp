#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> fairCandySwap(vector<int>& A, vector<int>& B) {
        int sumA = 0;
        int sumB = 0;
        for (int a : A) sumA += a;
        for (int b : B) sumB += b;

        int delta = (sumA - sumB) / 2;

        unordered_set<int> setB(B.begin(), B.end());

        for (int a : A) {
            if (setB.find(a - delta) != setB.end()) {
                return {a, a - delta};
            }
        }

        return {};
    }
};