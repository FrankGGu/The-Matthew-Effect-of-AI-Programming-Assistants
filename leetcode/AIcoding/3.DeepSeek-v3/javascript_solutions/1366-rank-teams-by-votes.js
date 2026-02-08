var rankTeams = function(votes) {
    if (votes.length === 0) return "";
    const teamCount = votes[0].length;
    const rankMap = {};

    for (const team of votes[0]) {
        rankMap[team] = new Array(teamCount).fill(0);
    }

    for (const vote of votes) {
        for (let i = 0; i < vote.length; i++) {
            const team = vote[i];
            rankMap[team][i]++;
        }
    }

    const teams = Object.keys(rankMap);
    teams.sort((a, b) => {
        for (let i = 0; i < teamCount; i++) {
            if (rankMap[a][i] !== rankMap[b][i]) {
                return rankMap[b][i] - rankMap[a][i];
            }
        }
        return a.charCodeAt(0) - b.charCodeAt(0);
    });

    return teams.join('');
};