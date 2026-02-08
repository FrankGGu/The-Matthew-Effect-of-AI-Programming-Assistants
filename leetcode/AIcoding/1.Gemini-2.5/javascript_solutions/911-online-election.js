var TopVotedCandidate = function(persons, times) {
    this.leaders = [];
    let voteCounts = {};
    let maxVotes = 0;
    let currentLeader = -1;

    for (let i = 0; i < persons.length; i++) {
        const person = persons[i];
        const time = times[i];

        voteCounts[person] = (voteCounts[person] || 0) + 1;
        const personVotes = voteCounts[person];

        if (personVotes >= maxVotes) {
            maxVotes = personVotes;
            currentLeader = person;
        }
        this.leaders.push([time, currentLeader]);
    }
};

TopVotedCandidate.prototype.q = function(t) {
    let low = 0;
    let high = this.leaders.length - 1;
    let ansIndex = 0;

    while (low <= high) {
        let mid = Math.floor(low + (high - low) / 2);
        if (this.leaders[mid][0] <= t) {
            ansIndex = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return this.leaders[ansIndex][1];
};