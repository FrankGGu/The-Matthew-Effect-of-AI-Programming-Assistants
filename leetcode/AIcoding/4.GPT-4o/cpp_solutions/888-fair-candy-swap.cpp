#include <vector>
#include <unordered_set>
using namespace std;

vector<int> fairCandySwap(vector<int>& A, vector<int>& B) {
    int sumA = 0, sumB = 0;
    for (int a : A) sumA += a;
    for (int b : B) sumB += b;

    int delta = (sumA - sumB) / 2;
    unordered_set<int> setA(A.begin(), A.end());

    for (int b : B) {
        if (setA.count(b + delta)) {
            return {b + delta, b};
        }
    }
    return {};
}