#include <vector>
#include <string>

using namespace std;

vector<int> addToArrayForm(vector<int>& A, int K) {
    int n = A.size();
    vector<int> result;
    int carry = 0;

    for (int i = n - 1; i >= 0 || K > 0 || carry > 0; --i) {
        if (i >= 0) carry += A[i];
        if (K > 0) {
            carry += K % 10;
            K /= 10;
        }
        result.push_back(carry % 10);
        carry /= 10;
    }

    reverse(result.begin(), result.end());
    return result;
}