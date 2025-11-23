#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string getHint(string secret, string guess) {
        unordered_map<char, int> count;
        int bulls = 0;
        int cows = 0;

        for (int i = 0; i < secret.length(); ++i) {
            if (secret[i] == guess[i]) {
                bulls++;
            } else {
                count[secret[i]]++;
                count[guess[i]]++;
            }
        }

        for (auto& [c, cnt] : count) {
            cows += cnt / 2;
        }

        return to_string(bulls) + "A" + to_string(cows) + "B";
    }
};