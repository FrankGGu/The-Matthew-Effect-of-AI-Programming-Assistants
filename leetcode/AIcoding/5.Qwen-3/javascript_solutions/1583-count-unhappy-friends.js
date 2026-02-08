function unhappyFriends(n, preferences, pairs) {
    const friendOf = new Array(n).fill(0).map(() => new Array(n).fill(0));
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n - 1; j++) {
            friendOf[i][preferences[i][j]] = j;
        }
    }

    const isUnhappy = new Array(n).fill(false);
    const pairSet = new Set();

    for (const [x, y] of pairs) {
        pairSet.add(x);
        pairSet.add(y);
    }

    for (const x of pairSet) {
        const y = pairs.find(p => p[0] === x || p[1] === x)[0] === x ? pairs.find(p => p[0] === x || p[1] === x)[1] : pairs.find(p => p[0] === x || p[1] === x)[0];
        for (let i = 0; i < n - 1; i++) {
            const z = preferences[x][i];
            if (z === y) break;
            const zToX = friendOf[z][x];
            const zToZ = friendOf[z][z];
            if (zToX < zToZ) {
                isUnhappy[x] = true;
                break;
            }
        }
    }

    return isUnhappy.filter(b => b).length;
}