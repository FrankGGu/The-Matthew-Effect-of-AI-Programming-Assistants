class Solution {
public:
    bool canMove(string& position, string& direction) {
        int x = position[0] - 'a', y = position[1] - '1';
        int dx = direction[0] == 'U' ? -1 : direction[0] == 'D' ? 1 : 0;
        int dy = direction[1] == 'L' ? -1 : direction[1] == 'R' ? 1 : 0;

        int newX = x + dx, newY = y + dy;
        return newX >= 0 && newX < 8 && newY >= 0 && newY < 8;
    }

    bool canMove(string position, string direction) {
        return canMove(position, direction);
    }

    bool canMove(string position, string direction) {
        return canMove(position, direction);
    }
};