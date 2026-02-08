#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

class Solution {
public:
    int uniqueMorseRepresentations(std::vector<std::string>& words) {
        std::vector<std::string> morseCodes = {".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.",
                                               "---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."};
        std::unordered_set<std::string> uniqueMorse;

        for (const auto& word : words) {
            std::string morse;
            for (char c : word) {
                morse += morseCodes[c - 'a'];
            }
            uniqueMorse.insert(morse);
        }

        return uniqueMorse.size();
    }
};