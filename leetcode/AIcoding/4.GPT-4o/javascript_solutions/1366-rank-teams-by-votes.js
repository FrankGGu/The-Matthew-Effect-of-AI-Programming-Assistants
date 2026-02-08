var rankTeams = function(votes) {
    const count = {};
    const n = votes.length;

    for (const vote of votes) {
        for (let i = 0; i < vote.length; i++) {
            const team = vote[i];
            if (!count[team]) count[team] = new Array(vote.length).fill(0);
            count[team][i]++;
        }
    }

    const teams = Object.keys(count);

    teams.sort((a, b) => {
        for (let i = 0; i < n; i++) {
            if (count[b][i] !== count[a][i]) {
                return count[b][i] - count[a][i];
            }
        }
        return a.localeCompare(b);
    });

    return teams.join('');
};