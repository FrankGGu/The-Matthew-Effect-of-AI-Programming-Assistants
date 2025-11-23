function minimumMoves(blocks) {
    let n = blocks.length;
    let left = 0, right = n - 1;
    let moves = 0;

    while (left < right) {
        if (blocks[left] === 'W') {
            left++;
        } else if (blocks[right] === 'B') {
            right--;
        } else {
            if (blocks[left] === 'B' && blocks[right] === 'W') {
                moves++;
                left++;
                right--;
            }
        }
    }

    return moves;
}