var numTilePossibilities = function(tiles) {
    const set = new Set();

    const backtrack = (current) => {
        set.add(current);
        for (let i = 0; i < tiles.length; i++) {
            backtrack(current + tiles[i]);
            tiles = tiles.slice(0, i) + tiles.slice(i + 1);
        }
    };

    backtrack('');
    return set.size - 1; // Subtract 1 to exclude the empty string
};