var numTilePossibilities = function(tiles) {
    let count = 0;
    let set = new Set();

    function backtrack(str, remaining) {
        if (str.length > 0 && !set.has(str)) {
            count++;
            set.add(str);
        }

        if (remaining.length === 0) {
            return;
        }

        for (let i = 0; i < remaining.length; i++) {
            let newStr = str + remaining[i];
            let newRemaining = remaining.slice(0, i) + remaining.slice(i + 1);
            backtrack(newStr, newRemaining);
        }
    }

    backtrack("", tiles);
    return count;
};