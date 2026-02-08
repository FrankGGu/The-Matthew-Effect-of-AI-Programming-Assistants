var findDiagonalOrder = function(mat) {
    if (!mat || mat.length === 0 || mat[0].length === 0) {
        return [];
    }

    const m = mat.length;
    const n = mat[0].length;
    const result = [];

    let r = 0;
    let c = 0;
    let direction = 1; // 1 for up-right, -1 for down-left

    for (let i = 0; i < m * n; i++) {
        result.push(mat[r][c]);

        if (direction === 1) { // Moving up-right
            const nextR = r - 1;
            const nextC = c + 1;

            if (nextR < 0 || nextC >= n) { // Hit a boundary
                direction = -1; // Change to down-left
                // Adjust current r, c to the next starting point for down-left diagonal
                if (c + 1 < n) { // Try moving right from current c
                    c++;
                } else { // Must move down from current r
                    r++;
                }
            } else { // No boundary hit, just move
                r = nextR;
                c = nextC;
            }
        } else { // Moving down-left
            const nextR = r + 1;
            const nextC = c - 1;

            if (nextR >= m || nextC < 0) { // Hit a boundary
                direction = 1; // Change to up-right
                // Adjust current r, c to the next starting point for up-right diagonal
                if (r + 1 < m) { // Try moving down from current r
                    r++;
                } else { // Must move right from current c
                    c++;
                }
            } else { // No boundary hit, just move
                r = nextR;
                c = nextC;
            }
        }
    }

    return result;
};