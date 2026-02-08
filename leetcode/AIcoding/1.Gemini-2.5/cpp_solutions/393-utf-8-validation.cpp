#include <vector>

class Solution {
public:
    bool isValidUtf8(std::vector<int>& data) {
        int bytesToProcess = 0;

        for (int byte : data) {
            if (bytesToProcess == 0) {
                if ((byte & 0b10000000) == 0b00000000) {
                    // 1-byte character: 0xxxxxxx
                } else if ((byte & 0b11100000) == 0b11000000) {
                    // 2-byte character: 110xxxxx
                    bytesToProcess = 1;
                } else if ((byte & 0b11110000) == 0b11100000) {
                    // 3-byte character: 1110xxxx
                    bytesToProcess = 2;
                } else if ((byte & 0b11111000) == 0b11110000) {
                    // 4-byte character: 11110xxx
                    bytesToProcess = 3;
                } else {
                    // Invalid start byte (e.g., 10xxxxxx or 11111xxx)
                    return false;
                }
            } else {
                // Expecting a continuation byte: 10xxxxxx
                if ((byte & 0b11000000) == 0b10000000) {
                    bytesToProcess--;
                } else {
                    // Not a valid continuation byte
                    return false;
                }
            }
        }

        return bytesToProcess == 0;
    }
};