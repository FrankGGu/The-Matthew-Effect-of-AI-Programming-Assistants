class Solution {
public:
    string alphabetBoardPath(string target) {
        string res;
        int x = 0, y = 0;
        for (char c : target) {
            int nx = (c - 'a') / 5;
            int ny = (c - 'a') % 5;
            while (x > nx) { res += 'U'; x--; }
            while (y > ny) { res += 'L'; y--; }
            while (y < ny) { res += 'R'; y++; }
            while (x < nx) { res += 'D'; x++; }
            res += '!';
        }
        return res;
    }
};