#include <string>
#include <algorithm> // Required for std::min

class Solution {
public:
    std::string getSmallestString(int n, int k) {
        std::string s(n, 'a');
        k -= n; 

        for (int i = n - 1; i >= 0; --i) {
            if (k == 0) {
                break;
            }
            int can_add = std::min(k, 25); 
            s[i] += can_add;
            k -= can_add;
        }
        return s;
    }
};