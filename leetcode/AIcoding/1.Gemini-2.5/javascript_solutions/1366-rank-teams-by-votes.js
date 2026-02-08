var rankTeams = function(votes) {
    if (votes.length === 0) {
        return "";
    }

    const numRanks = votes[0].length;
    const teamStats = new Map();

    // Initialize team stats for all teams present in the first vote
    // Each team gets an array to store counts for each rank
    for (const team of votes[0]) {
        teamStats.set(team, new Array(numRanks).fill(0));
    }

    // Populate team stats based on votes
    for (const vote of votes) {
        for (let i = 0; i < numRanks; i++) {
            const team = vote[i];
            // Increment the count for this team at this rank
            teamStats.get(team)[i]++;
        }
    }

    // Get the list of all teams and sort them
    const teams = Array.from(teamStats.keys());

    teams.sort((teamA, teamB) => {
        const statsA = teamStats.get(teamA);
        const statsB = teamStats.get(teamB);

        // Compare rank by rank
        for (let i = 0; i < numRanks; i++) {
            if (statsA[i] !== statsB[i]) {
                // Higher vote count for a rank means higher priority
                return statsB[i] - statsA[i];
            }
        }
        // If all ranks are tied, sort alphabetically
        return teamA.localeCompare(teamB);
    });

    return teams.join('');
};