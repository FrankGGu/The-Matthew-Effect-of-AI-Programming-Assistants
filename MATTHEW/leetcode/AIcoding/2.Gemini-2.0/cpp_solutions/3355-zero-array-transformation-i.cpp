#include <vector>

using namespace std;

class Solution {
public:
    bool canConvert(vector<int>& a, vector<int>& b) {
        int n = a.size();
        if (n != b.size()) return false;
        if (n == 0) return true;

        if (a[n - 1] != b[n - 1]) return false;

        return true;
    }
};