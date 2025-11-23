bool squareIsWhite(char * coordinates){
    int col_num = coordinates[0] - 'a' + 1;
    int row_num = coordinates[1] - '0';

    int sum = col_num + row_num;

    // 'a1' is black. (1+1=2, even sum)
    // If sum is even, it's black.
    // If sum is odd, it's white.
    // The function should return true if white, false if black.
    return (sum % 2 != 0);
}