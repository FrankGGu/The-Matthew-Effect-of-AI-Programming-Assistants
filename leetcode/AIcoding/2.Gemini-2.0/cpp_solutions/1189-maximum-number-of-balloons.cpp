#include <string>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int maxNumberOfBalloons(string text) {
        map<char, int> textCount;
        for (char c : text) {
            textCount[c]++;
        }

        map<char, int> balloonCount = {
            {'b', 0},
            {'a', 0},
            {'l', 0},
            {'o', 0},
            {'n', 0}
        };

        balloonCount['b'] = textCount['b'];
        balloonCount['a'] = textCount['a'];
        balloonCount['l'] = textCount['l'] / 2;
        balloonCount['o'] = textCount['o'] / 2;
        balloonCount['n'] = textCount['n'];

        int minCount = INT_MAX;
        for (auto const& [key, val] : balloonCount) {
            minCount = min(minCount, val);
        }

        return minCount;
    }
};