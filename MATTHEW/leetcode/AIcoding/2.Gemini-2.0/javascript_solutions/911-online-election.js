var TopVotedCandidate = function(persons, times) {
    this.persons = persons;
    this.times = times;
    this.leaderHistory = [];
    let votes = {};
    let leader = -1;
    let maxVotes = -1;

    for (let i = 0; i < persons.length; i++) {
        const person = persons[i];
        votes[person] = (votes[person] || 0) + 1;
        if (votes[person] >= maxVotes) {
            maxVotes = votes[person];
            leader = person;
        }
        this.leaderHistory.push(leader);
    }
};

TopVotedCandidate.prototype.q = function(t) {
    let left = 0;
    let right = this.times.length - 1;
    let index = -1;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (this.times[mid] <= t) {
            index = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return this.leaderHistory[index];
};