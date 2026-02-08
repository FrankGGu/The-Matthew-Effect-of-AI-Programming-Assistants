#include <string>
#include <vector>

class Solution {
public:
    std::string getHint(std::string secret, std::string guess) {
        int bulls = 0;
        int cows = 0;
        std::vector<int> counts(10, 0);

        for (int i = 0; i < secret.length(); ++i) {
            if (secret[i] == guess[i]) {
                bulls++;
            } else {
                if (counts[secret[i] - '0']++ < 0) {
                    cows++;
                }
                if (counts[guess[i] - '0']-- > 0) {
                    cows++;
                }
            }
        }

        return std::to_string(bulls) + "A" + std::to_string(cows) + "B";
    }
};