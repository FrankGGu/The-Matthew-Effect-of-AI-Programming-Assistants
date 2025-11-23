#include <string>
#include <vector>
#include <algorithm>

using namespace std;

string getSmallestString(int n, int k) {
    string result(n, 'a');
    k -= n;
    for (int i = n - 1; i >= 0 && k > 0; --i) {
        int add = min(k, 25);
        result[i] += add;
        k -= add;
    }
    return result;
}