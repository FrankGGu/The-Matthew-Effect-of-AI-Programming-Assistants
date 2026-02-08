var rand10 = function() {
    let row, col, idx;
    do {
        row = Rand7() - 1;
        col = Rand7() - 1;
        idx = row * 7 + col; // 0 to 48
    } while (idx >= 40);
    return (idx % 10) + 1; // 1 to 10
};