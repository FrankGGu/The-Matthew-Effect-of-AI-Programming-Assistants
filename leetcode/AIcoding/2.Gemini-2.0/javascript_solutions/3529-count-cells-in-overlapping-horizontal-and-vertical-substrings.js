var countCells = function(n, s) {
    let rows = new Set();
    let cols = new Set();

    for (let str of s) {
        if (str.includes('h')) {
            let start = parseInt(str.substring(0, str.indexOf('h')));
            let end = parseInt(str.substring(str.indexOf('h') + 1));
            for (let i = start; i <= end; i++) {
                rows.add(i);
            }
        } else {
            let start = parseInt(str.substring(0, str.indexOf('v')));
            let end = parseInt(str.substring(str.indexOf('v') + 1));
            for (let i = start; i <= end; i++) {
                cols.add(i);
            }
        }
    }

    return rows.size * cols.size;
};