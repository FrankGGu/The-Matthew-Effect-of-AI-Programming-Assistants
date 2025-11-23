#include <vector>
#include <string>
#include <unordered_set>

class Solution {
public:
    int uniqueMorseRepresentations(std::vector<std::string>& words) {
        std::vector<std::string> morse_map = {".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."};
        std::unordered_set<std::string> unique_transformations;

        for (const std::string& word : words) {
            std::string transformation = "";
            for (char c : word) {
                transformation += morse_map[c - 'a'];
            }
            unique_transformations.insert(transformation);
        }

        return unique_transformations.size();
    }
};