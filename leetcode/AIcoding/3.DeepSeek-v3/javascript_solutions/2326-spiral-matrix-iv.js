var spiralMatrix = function(m, n, head) {
    const matrix = new Array(m).fill().map(() => new Array(n).fill(-1));
    let top = 0, bottom = m - 1, left = 0, right = n - 1;
    let current = head;

    while (current !== null && top <= bottom && left <= right) {
        for (let i = left; i <= right && current !== null; i++) {
            matrix[top][i] = current.val;
            current = current.next;
        }
        top++;

        for (let i = top; i <= bottom && current !== null; i++) {
            matrix[i][right] = current.val;
            current = current.next;
        }
        right--;

        if (top <= bottom) {
            for (let i = right; i >= left && current !== null; i--) {
                matrix[bottom][i] = current.val;
                current = current.next;
            }
            bottom--;
        }

        if (left <= right) {
            for (let i = bottom; i >= top && current !== null; i--) {
                matrix[i][left] = current.val;
                current = current.next;
            }
            left++;
        }
    }

    return matrix;
};