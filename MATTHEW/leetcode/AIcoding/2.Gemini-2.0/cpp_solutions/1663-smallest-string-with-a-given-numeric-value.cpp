#include <string>

using namespace std;

class Solution {
public:
    string getSmallestString(int n, int k) {
        string result(n, 'a');
        k -= n;
        for (int i = n - 1; i >= 0 && k > 0; --i) {
            int add = min(25, k);
            result[i] += add;
            k -= add;
        }
        return result;
    }
};