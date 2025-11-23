#include <string>
#include <vector>
#include <algorithm>
#include <map>

class Solution {
public:
    std::string originalDigits(std::string s) {
        std::vector<int> char_counts(26, 0);
        for (char c : s) {
            char_counts[c - 'a']++;
        }

        std::vector<int> digit_counts(10, 0);

        // Digits with unique characters
        digit_counts[0] = char_counts['z' - 'a']; // zero
        digit_counts[2] = char_counts['w' - 'a']; // two
        digit_counts[4] = char_counts['u' - 'a']; // four
        digit_counts[6] = char_counts['x' - 'a']; // six
        digit_counts[8] = char_counts['g' - 'a']; // eight

        // Digits whose unique characters become unique after removing previous ones
        digit_counts[3] = char_counts['h' - 'a'] - digit_counts[8]; // three (h in eight)
        digit_counts[5] = char_counts['f' - 'a'] - digit_counts[4]; // five (f in four)
        digit_counts[7] = char_counts['s' - 'a'] - digit_counts[6]; // seven (s in six)

        // Digits whose unique characters become unique after removing previous ones (more complex)
        digit_counts[1] = char_counts['o' - 'a'] - digit_counts[0] - digit_counts[2] - digit_counts[4]; // one (o in zero, two, four)
        digit_counts[9] = char_counts['i' - 'a'] - digit_counts[5] - digit_counts[6] - digit_counts[8]; // nine (i in five, six, eight)

        std::string result = "";
        for (int i = 0; i < 10; ++i) {
            result += std::string(digit_counts[i], i + '0');
        }

        return result;
    }
};