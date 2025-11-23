var numTilePossibilities = function(tiles) {
    const count = {};
    for (const tile of tiles) {
        count[tile] = (count[tile] || 0) + 1;
    }
    return dfs(count);
};

function dfs(count) {
    let sum = 0;
    for (const tile in count) {
        if (count[tile] > 0) {
            sum++;
            count[tile]--;
            sum += dfs(count);
            count[tile]++;
        }
    }
    return sum;
}