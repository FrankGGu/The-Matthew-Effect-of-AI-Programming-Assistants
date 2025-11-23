#include <string>
#include <algorithm> // For std::max

class Solution {
public:
    bool checkZeroOnes(std::string s) {
        int maxOnes = 0;
        int maxZeros = 0;
        int currentOnes = 0;
        int currentZeros = 0;

        for (char c : s) {
            if (c == '1') {
                currentOnes++;
                currentZeros = 0;
                maxOnes = std::max(maxOnes, currentOnes);
            } else { // c == '0'
                currentZeros++;
                currentOnes = 0;
                maxZeros = std::max(maxZeros, currentZeros);
            }
        }

        return maxOnes > maxZeros;
    }
};