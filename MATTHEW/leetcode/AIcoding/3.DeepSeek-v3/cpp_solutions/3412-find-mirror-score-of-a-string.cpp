#include <unordered_map>
#include <string>

using namespace std;

class Solution {
public:
    int findMirrorScore(string s) {
        unordered_map<char, char> mirror = {
            {'b', 'd'}, {'d', 'b'},
            {'p', 'q'}, {'q', 'p'},
            {'a', 'a'}, {'o', 'o'},
            {'H', 'H'}, {'I', 'I'},
            {'M', 'M'}, {'O', 'O'},
            {'T', 'T'}, {'U', 'U'},
            {'V', 'V'}, {'v', 'v'},
            {'W', 'W'}, {'w', 'w'},
            {'X', 'X'}, {'x', 'x'},
            {'Y', 'Y'}
        };

        int n = s.size();
        int score = 0;
        for (int i = 0; i <= n - 1 - i; ++i) {
            char left = s[i];
            char right = s[n - 1 - i];
            if (mirror.count(left) && mirror[left] == right) {
                if (i == n - 1 - i) {
                    score += 1;
                } else {
                    score += 2;
                }
            }
        }
        return score;
    }
};