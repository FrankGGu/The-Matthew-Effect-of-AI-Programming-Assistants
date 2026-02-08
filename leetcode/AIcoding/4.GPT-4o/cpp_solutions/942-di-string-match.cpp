#include <vector>
#include <string>
using namespace std;

vector<int> diStringMatch(string S) {
    int n = S.size();
    vector<int> result(n + 1);
    int low = 0, high = n;

    for (int i = 0; i < n; ++i) {
        if (S[i] == 'I') {
            result[i] = low++;
        } else {
            result[i] = high--;
        }
    }
    result[n] = low; // or result[n] = high; both are the same
    return result;
}