var rankTeams = function(votes) {
    const n = votes[0].length;
    const m = votes.length;
    const rankMap = {};
    for (let i = 0; i < n; i++) {
        rankMap[votes[0][i]] = new Array(n).fill(0);
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            rankMap[votes[i][j]][j]++;
        }
    }

    return votes[0].split('').sort((a, b) => {
        for (let i = 0; i < n; i++) {
            if (rankMap[a][i] !== rankMap[b][i]) {
                return rankMap[b][i] - rankMap[a][i];
            }
        }
        return a.charCodeAt(0) - b.charCodeAt(0);
    }).join('');
};