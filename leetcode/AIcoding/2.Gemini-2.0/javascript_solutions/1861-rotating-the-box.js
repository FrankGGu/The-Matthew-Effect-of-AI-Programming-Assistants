var rotateTheBox = function(box) {
    const m = box.length;
    const n = box[0].length;
    const rotatedBox = Array(n).fill(null).map(() => Array(m).fill(null));

    for (let i = 0; i < m; i++) {
        let lastEmpty = n - 1;
        for (let j = n - 1; j >= 0; j--) {
            if (box[i][j] === '#') {
                rotatedBox[j][m - 1 - i] = '.';
                rotatedBox[lastEmpty][m - 1 - i] = '#';
                if (lastEmpty !== j) {
                    box[i][j] = '.';
                }
                box[i][lastEmpty] = '#';
                lastEmpty--;
            } else if (box[i][j] === '*') {
                rotatedBox[j][m - 1 - i] = '*';
                lastEmpty = j - 1;
            } else {
                rotatedBox[j][m - 1 - i] = '.';
            }
        }
    }

    return rotatedBox;
};