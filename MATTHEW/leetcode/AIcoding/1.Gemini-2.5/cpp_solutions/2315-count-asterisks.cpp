class Solution {
public:
    int countAsterisks(std::string s) {
        int count = 0;
        bool in_pair = false;
        for (char c : s) {
            if (c == '|') {
                in_pair = !in_pair;
            } else if (c == '*' && !in_pair) {
                count++;
            }
        }
        return count;
    }
};