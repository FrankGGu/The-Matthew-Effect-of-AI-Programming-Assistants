#include <string>

using namespace std;

class Solution {
public:
    int get_num(string s) {
        int num = 0;
        for (char c : s) {
            num = num * 10 + (c - 'a');
        }
        return num;
    }

    bool isSumEqual(string firstWord, string secondWord, string targetWord) {
        return get_num(firstWord) + get_num(secondWord) == get_num(targetWord);
    }
};