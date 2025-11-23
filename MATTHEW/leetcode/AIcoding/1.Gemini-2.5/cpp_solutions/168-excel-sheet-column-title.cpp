#include <string>
#include <algorithm> // Required for std::reverse

class Solution {
public:
    std::string convertToTitle(int columnNumber) {
        std::string result = "";
        while (columnNumber > 0) {
            columnNumber--; 
            int remainder = columnNumber % 26;
            result.push_back('A' + remainder);
            columnNumber /= 26;
        }
        std::reverse(result.begin(), result.end());
        return result;
    }
};