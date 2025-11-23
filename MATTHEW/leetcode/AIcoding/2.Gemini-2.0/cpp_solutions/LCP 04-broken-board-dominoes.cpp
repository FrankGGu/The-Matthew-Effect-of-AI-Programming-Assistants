#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int domino(int n, int m, int brokenRows, int brokenCols) {
        if ((n * m - brokenRows - brokenCols) % 2 != 0) {
            return 0;
        }
        return (n * m - brokenRows - brokenCols) / 2;
    }
};