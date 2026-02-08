#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumChairs(string s) {
        int max_chairs = 0;
        int current = 0;
        for (char c : s) {
            if (c == 'E') {
                current++;
                max_chairs = max(max_chairs, current);
            } else {
                current--;
            }
        }
        return max_chairs;
    }
};