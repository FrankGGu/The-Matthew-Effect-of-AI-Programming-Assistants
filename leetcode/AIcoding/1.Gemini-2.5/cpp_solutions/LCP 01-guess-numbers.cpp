class Solution {
public:
    int game(std::vector<int>& guess, std::vector<int>& answer) {
        int matches = 0;
        if (guess[0] == answer[0]) {
            matches++;
        }
        if (guess[1] == answer[1]) {
            matches++;
        }
        if (guess[2] == answer[2]) {
            matches++;
        }
        return matches;
    }
};