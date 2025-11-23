var unhappyFriends = function(n, preferences, pairs) {
    const match = new Array(n).fill(0);
    for (const [x, y] of pairs) {
        match[x] = y;
        match[y] = x;
    }

    let unhappy = new Set();

    for (let x = 0; x < n; x++) {
        let y = match[x];
        for (let u of preferences[x]) {
            if (u === y) break;
            let v = match[u];
            let u_pref = preferences[u];
            for (let w of u_pref) {
                if (w === v) break;
                if (w === x) {
                    unhappy.add(x);
                    break;
                }
            }
            if (unhappy.has(x)) break;
        }
    }

    let unhappy2 = new Set();
    for (let x = 0; x < n; x++) {
        let y = match[x];
        for (let u of preferences[x]) {
            if (u === y) break;
            let v = match[u];
            let u_pref = preferences[u];
            for (let w of u_pref) {
                if (w === v) break;
                if (w === x) {
                    unhappy2.add(u);
                    break;
                }
            }
            if (unhappy2.has(u)) break;
        }
    }

    return new Set([...unhappy, ...unhappy2]).size;
};