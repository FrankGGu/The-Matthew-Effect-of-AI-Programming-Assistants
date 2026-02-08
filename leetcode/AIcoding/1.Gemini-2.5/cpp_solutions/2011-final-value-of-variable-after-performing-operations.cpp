#include <vector>
#include <string>

class Solution {
public:
    int finalValueAfterOperations(std::vector<std::string>& operations) {
        int x = 0;
        for (const std::string& op : operations) {
            if (op[1] == '+') {
                x++;
            } else {
                x--;
            }
        }
        return x;
    }
};