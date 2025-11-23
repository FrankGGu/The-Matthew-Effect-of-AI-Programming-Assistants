#include <algorithm>

using namespace std;

class Solution {
public:
    int longestString(int x, int y, int z) {
        return 2 * (min(x, y) + z) + (x != y ? 2 : 0);
    }
};