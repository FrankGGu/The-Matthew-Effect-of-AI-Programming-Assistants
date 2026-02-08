#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> memLeak(int memory1, int memory2) {
        long long i = 1;
        while (true) {
            if (memory1 >= i && memory2 >= i) {
                if (memory1 >= memory2) {
                    memory1 -= i;
                } else {
                    memory2 -= i;
                }
            } else if (memory1 >= i) {
                memory1 -= i;
            } else if (memory2 >= i) {
                memory2 -= i;
            } else {
                break; 
            }
            i++;
        }
        return {(int)i, memory1, memory2};
    }
};