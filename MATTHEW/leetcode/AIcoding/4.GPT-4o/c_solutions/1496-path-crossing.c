bool isPathCrossing(char * path) {
    int x = 0, y = 0;
    bool visited[201][201] = { false };
    visited[100][100] = true;

    for (int i = 0; path[i]; i++) {
        if (path[i] == 'N') y++;
        else if (path[i] == 'S') y--;
        else if (path[i] == 'E') x++;
        else if (path[i] == 'W') x--;

        if (visited[y + 100][x + 100]) return true;
        visited[y + 100][x + 100] = true;
    }

    return false;
}