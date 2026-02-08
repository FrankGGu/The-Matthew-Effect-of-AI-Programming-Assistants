#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> twoEditWords(vector<string>& queries, vector<string>& dictionary) {
        vector<string> result;
        for (const string& word : queries) {
            int count = 0;
            for (int i = 0; i < word.length(); ++i) {
                if (word[i] != dictionary[i]) {
                    ++count;
                    if (count > 2) break;
                }
            }
            if (count <= 2) {
                result.push_back(word);
            }
        }
        return result;
    }
};