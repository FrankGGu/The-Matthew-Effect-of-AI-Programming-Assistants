bool squaresAreSameColor(char *coordinates) {
    return (coordinates[0] - 'a' + coordinates[1] - '1') % 2 == 0;
}