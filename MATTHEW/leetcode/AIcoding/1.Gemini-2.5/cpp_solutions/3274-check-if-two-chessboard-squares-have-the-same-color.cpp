#include <string>

class Solution {
public:
    bool areColorsSame(std::string coordinates1, std::string coordinates2) {
        int col1 = coordinates1[0] - 'a';
        int row1 = coordinates1[1] - '1';

        int col2 = coordinates2[0] - 'a';
        int row2 = coordinates2[1] - '1';

        return ((col1 + row1) % 2) == ((col2 + row2) % 2);
    }
};