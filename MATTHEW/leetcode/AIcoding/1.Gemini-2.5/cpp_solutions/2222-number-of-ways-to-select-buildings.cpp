#include <string>
#include <vector>

class Solution {
public:
    long long numberOfWays(std::string s) {
        long long totalZeros = 0;
        long long totalOnes = 0;

        for (char c : s) {
            if (c == '0') {
                totalZeros++;
            } else {
                totalOnes++;
            }
        }

        long long ans = 0;
        long long zerosCount = 0; 
        long long onesCount = 0;  

        for (char c : s) {
            if (c == '0') {
                ans += onesCount * (totalOnes - onesCount);
                zerosCount++;
            } else { // c == '1'
                ans += zerosCount * (totalZeros - zerosCount);
                onesCount++;
            }
        }

        return ans;
    }
};