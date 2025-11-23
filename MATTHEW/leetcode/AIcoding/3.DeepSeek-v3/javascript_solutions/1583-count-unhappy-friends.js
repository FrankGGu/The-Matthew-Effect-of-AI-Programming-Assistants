var unhappyFriends = function(n, preferences, pairs) {
    let rank = new Array(n);
    for (let i = 0; i < n; i++) {
        rank[i] = new Array(n);
        for (let j = 0; j < preferences[i].length; j++) {
            rank[i][preferences[i][j]] = j;
        }
    }

    let pairMap = new Array(n);
    for (let [x, y] of pairs) {
        pairMap[x] = y;
        pairMap[y] = x;
    }

    let unhappy = 0;
    for (let x = 0; x < n; x++) {
        let y = pairMap[x];
        for (let u of preferences[x]) {
            if (u === y) break;
            let v = pairMap[u];
            if (rank[u][x] < rank[u][v]) {
                unhappy++;
                break;
            }
        }
    }
    return unhappy;
};