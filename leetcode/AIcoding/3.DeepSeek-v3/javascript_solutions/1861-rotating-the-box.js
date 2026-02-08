var rotateTheBox = function(box) {
    const m = box.length;
    const n = box[0].length;

    for (let i = 0; i < m; i++) {
        let pos = n - 1;
        for (let j = n - 1; j >= 0; j--) {
            if (box[i][j] === '*') {
                pos = j - 1;
            } else if (box[i][j] === '#') {
                box[i][j] = '.';
                box[i][pos] = '#';
                pos--;
            }
        }
    }

    const rotated = new Array(n).fill().map(() => new Array(m).fill('.'));
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            rotated[j][m - 1 - i] = box[i][j];
        }
    }

    return rotated;
};