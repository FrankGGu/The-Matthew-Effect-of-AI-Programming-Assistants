var spiralMatrix = function(m, n, head) {
    const result = Array.from({length: m}, () => Array(n).fill(0));
    let left = 0, right = n - 1, top = 0, bottom = m - 1;
    let index = 0;

    while (left <= right && top <= bottom) {
        for (let i = left; i <= right; i++) {
            if (index < head.length) result[top][i] = head[index++];
        }
        top++;
        for (let i = top; i <= bottom; i++) {
            if (index < head.length) result[i][right] = head[index++];
        }
        right--;
        if (top <= bottom) {
            for (let i = right; i >= left; i--) {
                if (index < head.length) result[bottom][i] = head[index++];
            }
            bottom--;
        }
        if (left <= right) {
            for (let i = bottom; i >= top; i--) {
                if (index < head.length) result[i][left] = head[index++];
            }
            left++;
        }
    }

    return result;
};