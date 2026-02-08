var unhappyFriends = function(N, preferences, pairs) {
    const index = new Array(N);
    for (let i = 0; i < N; i++) {
        index[i] = new Array(N);
        for (let j = 0; j < N; j++) {
            index[i][preferences[i][j]] = j;
        }
    }

    const partner = new Array(N);
    for (const [a, b] of pairs) {
        partner[a] = b;
        partner[b] = a;
    }

    let unhappyCount = 0;

    for (let i = 0; i < N; i++) {
        const partnerOfI = partner[i];
        for (let j = 0; j < preferences[i].length; j++) {
            const preferredFriend = preferences[i][j];
            if (preferredFriend === partnerOfI) break;
            if (index[preferredFriend][i] < index[preferredFriend][partner[preferredFriend]]) {
                unhappyCount++;
                break;
            }
        }
    }

    return unhappyCount;
};