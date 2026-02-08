#include <vector>

class Solution {
public:
    int storeHouse(std::vector<int>& actions) {
        int count = 0;
        bool has_one = false;

        for (int action : actions) {
            if (action == 1) {
                has_one = true;
            } else if (action == 2) {
                if (has_one) {
                    count++;
                    has_one = false;
                }
            }
        }

        return count;
    }
};