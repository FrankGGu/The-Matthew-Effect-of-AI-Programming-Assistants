var fortress = function(wall) {
    let n = wall.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        if (wall[i] === 1) {
            count++;
        }
    }

    return count;
};