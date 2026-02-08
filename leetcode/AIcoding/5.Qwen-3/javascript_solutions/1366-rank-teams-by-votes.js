function rankTeams(votes) {
    const count = {};
    const len = votes.length;
    for (let i = 0; i < len; i++) {
        const vote = votes[i];
        for (let j = 0; j < vote.length; j++) {
            const c = vote[j];
            if (!count[c]) {
                count[c] = new Array(10).fill(0);
            }
            count[c][j]++;
        }
    }

    const keys = Object.keys(count);
    return keys.sort((a, b) => {
        for (let i = 0; i < 10; i++) {
            if (count[a][i] !== count[b][i]) {
                return count[b][i] - count[a][i];
            }
        }
        return a.localeCompare(b);
    });
}