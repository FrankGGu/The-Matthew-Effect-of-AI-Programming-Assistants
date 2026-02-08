function numTilePossibilities(tiles) {
    const count = new Array(26).fill(0);
    for (const c of tiles) {
        count[c.charCodeAt(0) - 97]++;
    }

    function dfs() {
        let res = 0;
        for (let i = 0; i < 26; i++) {
            if (count[i] > 0) {
                count[i]--;
                res += 1 + dfs();
                count[i]++;
            }
        }
        return res;
    }

    return dfs();
}