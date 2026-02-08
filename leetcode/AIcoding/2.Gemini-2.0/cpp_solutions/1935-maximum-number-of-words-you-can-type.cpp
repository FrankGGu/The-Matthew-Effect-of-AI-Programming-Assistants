#include <string>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int canBeTypedWords(string text, string brokenLetters) {
        unordered_set<char> broken(brokenLetters.begin(), brokenLetters.end());
        int count = 0;
        string word;
        for (int i = 0; i <= text.size(); ++i) {
            if (i == text.size() || text[i] == ' ') {
                bool possible = true;
                for (char c : word) {
                    if (broken.count(c)) {
                        possible = false;
                        break;
                    }
                }
                if (possible) {
                    count++;
                }
                word = "";
            } else {
                word += text[i];
            }
        }
        return count;
    }
};