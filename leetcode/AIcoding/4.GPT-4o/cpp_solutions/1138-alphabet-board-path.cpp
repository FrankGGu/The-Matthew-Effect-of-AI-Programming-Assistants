class Solution {
public:
    string alphabetBoardPath(string target) {
        string result;
        int x = 0, y = 0;

        for (char c : target) {
            int newX = (c - 'a') / 5;
            int newY = (c - 'a') % 5;

            while (x > newX) { result += 'U'; x--; }
            while (y > newY) { result += 'L'; y--; }
            while (x < newX) { result += 'D'; x++; }
            while (y < newY) { result += 'R'; y++; }

            result += '!';
        }

        return result;
    }
};