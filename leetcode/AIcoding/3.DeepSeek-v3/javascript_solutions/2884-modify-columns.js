var modifyColumns = function(data) {
    if (data.length === 0 || data[0].length === 0) return data;

    const rows = data.length;
    const cols = data[0].length;

    for (let j = 0; j < cols; j++) {
        if (j % 2 === 0) {
            for (let i = 0; i < rows; i++) {
                data[i][j] += 1;
            }
        } else {
            for (let i = 0; i < rows; i++) {
                data[i][j] -= 1;
            }
        }
    }

    return data;
};