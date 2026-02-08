var TopVotedCandidate = function(persons, times) {
    this.times = times;
    this.leaderAtTime = [];
    let count = {};
    let currentLeader = -1;
    let maxVotes = 0;

    for (let i = 0; i < persons.length; i++) {
        const person = persons[i];
        count[person] = (count[person] || 0) + 1;
        if (count[person] >= maxVotes) {
            maxVotes = count[person];
            currentLeader = person;
        }
        this.leaderAtTime[i] = currentLeader;
    }
};

TopVotedCandidate.prototype.q = function(t) {
    let left = 0;
    let right = this.times.length - 1;
    let result = 0;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (this.times[mid] <= t) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return this.leaderAtTime[result];
};