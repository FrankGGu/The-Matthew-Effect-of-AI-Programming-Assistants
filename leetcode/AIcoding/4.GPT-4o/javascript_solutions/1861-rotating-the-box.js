var rotateTheBox = function(box) {
    const m = box.length, n = box[0].length;
    const result = Array.from({ length: n }, () => Array(m).fill('.'));

    for (let i = 0; i < m; i++) {
        let j = n - 1;
        for (let k = n - 1; k >= 0; k--) {
            if (box[i][k] === '#') {
                result[j--][i] = '#';
            } else if (box[i][k] === '*') {
                while (j > k) {
                    result[j--][i] = '.';
                }
                j--;
            }
        }
        while (j >= 0) {
            result[j--][i] = '.';
        }
    }

    return result;
};