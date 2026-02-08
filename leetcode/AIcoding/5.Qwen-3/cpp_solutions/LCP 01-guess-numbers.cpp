#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string getHint(string secret, string guess) {
        int bulls = 0;
        int cows = 0;
        vector<int> countSecret(10, 0);
        vector<int> countGuess(10, 0);

        for (int i = 0; i < secret.size(); ++i) {
            if (secret[i] == guess[i]) {
                bulls++;
            } else {
                countSecret[secret[i] - '0']++;
                countGuess[guess[i] - '0']++;
            }
        }

        for (int i = 0; i < 10; ++i) {
            cows += min(countSecret[i], countGuess[i]);
        }

        return to_string(bulls) + "A" + to_string(cows) + "B";
    }
};