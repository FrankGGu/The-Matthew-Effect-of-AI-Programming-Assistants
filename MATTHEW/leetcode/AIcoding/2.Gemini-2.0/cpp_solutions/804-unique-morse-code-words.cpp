#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int uniqueMorseRepresentations(vector<string>& words) {
        vector<string> morse = {".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."};
        unordered_set<string> transformations;
        for (string word : words) {
            string transformation = "";
            for (char c : word) {
                transformation += morse[c - 'a'];
            }
            transformations.insert(transformation);
        }
        return transformations.size();
    }
};