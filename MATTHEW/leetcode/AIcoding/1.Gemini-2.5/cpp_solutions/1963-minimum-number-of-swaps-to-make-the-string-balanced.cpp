class Solution {
public:
    int minSwaps(std::string s) {
        int open_count = 0;
        int unmatched_close_brackets = 0;

        for (char c : s) {
            if (c == '[') {
                open_count++;
            } else { // c == ']'
                if (open_count > 0) {
                    open_count--;
                } else {
                    unmatched_close_brackets++;
                }
            }
        }

        return (unmatched_close_brackets + 1) / 2;
    }
};