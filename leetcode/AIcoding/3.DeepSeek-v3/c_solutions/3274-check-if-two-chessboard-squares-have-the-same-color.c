bool checkTwoChessboards(char* coordinate1, char* coordinate2) {
    int x1 = coordinate1[0] - 'a';
    int y1 = coordinate1[1] - '1';
    int x2 = coordinate2[0] - 'a';
    int y2 = coordinate2[1] - '1';

    return (x1 + y1) % 2 == (x2 + y2) % 2;
}