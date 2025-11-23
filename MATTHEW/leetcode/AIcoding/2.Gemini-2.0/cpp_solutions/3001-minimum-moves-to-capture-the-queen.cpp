#include <algorithm>

using namespace std;

class Solution {
public:
    int minMovesToCaptureTheQueen(int rx, int ry, int bx, int by, int qx, int qy) {
        int moves = 3;

        // Rook
        bool blocked = false;
        if (rx == qx) {
            int start = min(ry, qy) + 1;
            int end = max(ry, qy);
            for (int i = start; i < end; ++i) {
                if (bx == rx && by == i) {
                    blocked = true;
                    break;
                }
            }
            if (!blocked) moves = min(moves, 1);
        }

        blocked = false;
        if (ry == qy) {
            int start = min(rx, qx) + 1;
            int end = max(rx, qx);
            for (int i = start; i < end; ++i) {
                if (by == ry && bx == i) {
                    blocked = true;
                    break;
                }
            }
            if (!blocked) moves = min(moves, 1);
        }

        // Bishop
        blocked = false;
        if (abs(bx - qx) == abs(by - qy)) {
            if ((bx - qx) == (by - qy)) {
                int xDir = (qx > bx) ? 1 : -1;
                int yDir = (qy > by) ? 1 : -1;
                int x = bx + xDir;
                int y = by + yDir;
                while (x != qx) {
                    if (rx == x && ry == y) {
                        blocked = true;
                        break;
                    }
                    x += xDir;
                    y += yDir;
                }
                if (!blocked) moves = min(moves, 2);
            } else {
                int xDir = (qx > bx) ? 1 : -1;
                int yDir = (qy > by) ? 1 : -1;
                int x = bx + xDir;
                int y = by + yDir;
                while (x != qx) {
                    if (rx == x && ry == y) {
                        blocked = true;
                        break;
                    }
                    x += xDir;
                    y += yDir;
                }
                if (!blocked) moves = min(moves, 2);
            }
        }

        blocked = false;
        if (abs(rx - qx) == abs(ry - qy)) {
            if ((rx - qx) == (ry - qy)) {
                int xDir = (qx > rx) ? 1 : -1;
                int yDir = (qy > ry) ? 1 : -1;
                int x = rx + xDir;
                int y = ry + yDir;
                while (x != qx) {
                    if (bx == x && by == y) {
                        blocked = true;
                        break;
                    }
                    x += xDir;
                    y += yDir;
                }
                if (!blocked) moves = min(moves, 2);
            } else {
                int xDir = (qx > rx) ? 1 : -1;
                int yDir = (qy > ry) ? 1 : -1;
                int x = rx + xDir;
                int y = ry + yDir;
                while (x != qx) {
                    if (bx == x && by == y) {
                        blocked = true;
                        break;
                    }
                    x += xDir;
                    y += yDir;
                }
                if (!blocked) moves = min(moves, 2);
            }
        }
        return moves;
    }
};