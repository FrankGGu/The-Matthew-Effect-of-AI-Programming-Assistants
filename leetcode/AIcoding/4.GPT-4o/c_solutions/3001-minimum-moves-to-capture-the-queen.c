int minQueenMoves(char* queen, char* king) {
    int qx = queen[0] - 'a', qy = queen[1] - '1';
    int kx = king[0] - 'a', ky = king[1] - '1';
    return (qx == kx || qy == ky || abs(qx - kx) == abs(qy - ky)) ? 1 : 2;
}