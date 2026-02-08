var spiralMatrix = function(m, n, head) {
    const grid = Array(m).fill(0).map(() => Array(n).fill(-1));

    let top = 0;
    let bottom = m - 1;
    let left = 0;
    let right = n - 1;

    let curr = head;

    while (top <= bottom && left <= right && curr) {
        // Traverse right
        for (let j = left; j <= right; j++) {
            if (!curr) break;
            grid[top][j] = curr.val;
            curr = curr.next;
        }
        top++;

        if (!(top <= bottom && left <= right && curr)) break;

        // Traverse down
        for (let i = top; i <= bottom; i++) {
            if (!curr) break;
            grid[i][right] = curr.val;
            curr = curr.next;
        }
        right--;

        if (!(top <= bottom && left <= right && curr)) break;

        // Traverse left
        for (let j = right; j >= left; j--) {
            if (!curr) break;
            grid[bottom][j] = curr.val;
            curr = curr.next;
        }
        bottom--;

        if (!(top <= bottom && left <= right && curr)) break;

        // Traverse up
        for (let i = bottom; i >= top; i--) {
            if (!curr) break;
            grid[i][left] = curr.val;
            curr = curr.next;
        }
        left++;
    }

    return grid;
};