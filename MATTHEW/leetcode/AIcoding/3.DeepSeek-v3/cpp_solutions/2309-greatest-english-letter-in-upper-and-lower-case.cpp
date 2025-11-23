class Solution {
public:
    string greatestLetter(string s) {
        unordered_set<char> seen;
        char max_char = 0;
        for (char c : s) {
            if (isupper(c)) {
                if (seen.count(tolower(c))) {
                    if (c > max_char) {
                        max_char = c;
                    }
                }
            } else {
                if (seen.count(toupper(c))) {
                    if (toupper(c) > max_char) {
                        max_char = toupper(c);
                    }
                }
            }
            seen.insert(c);
        }
        return max_char == 0 ? "" : string(1, max_char);
    }
};