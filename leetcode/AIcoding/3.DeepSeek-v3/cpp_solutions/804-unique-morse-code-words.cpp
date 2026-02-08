class Solution {
public:
    int uniqueMorseRepresentations(vector<string>& words) {
        vector<string> morse = {".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."};
        unordered_set<string> transformations;

        for (const string& word : words) {
            string code;
            for (char c : word) {
                code += morse[c - 'a'];
            }
            transformations.insert(code);
        }

        return transformations.size();
    }
};