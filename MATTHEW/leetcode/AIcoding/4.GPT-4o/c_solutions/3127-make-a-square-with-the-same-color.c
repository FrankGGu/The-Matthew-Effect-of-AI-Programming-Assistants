bool canMakeSquare(int** pieces, int piecesSize, int* piecesColSize) {
    int total = 0;
    for (int i = 0; i < piecesSize; i++) {
        total += pieces[i][0] * pieces[i][1];
    }
    if (total % 4 != 0) return false;
    int side = total / 4;
    int* sides = (int*)calloc(4, sizeof(int));
    bool result = dfs(pieces, piecesSize, piecesColSize, sides, 0, side);
    free(sides);
    return result;
}

bool dfs(int** pieces, int piecesSize, int* piecesColSize, int* sides, int index, int side) {
    if (index == piecesSize) {
        return sides[0] == sides[1] && sides[1] == sides[2] && sides[2] == sides[3] && sides[0] == side;
    }
    for (int i = 0; i < 4; i++) {
        if (sides[i] + pieces[index][0] <= side) {
            sides[i] += pieces[index][0];
            if (dfs(pieces, piecesSize, piecesColSize, sides, index + 1, side)) {
                return true;
            }
            sides[i] -= pieces[index][0];
        }
    }
    return false;
}