class TopVotedCandidate {
    constructor(persons, times) {
        this.leader = [];
        this.times = times;
        const count = {};
        let maxVotes = 0;
        let currentLeader = -1;

        for (let i = 0; i < persons.length; i++) {
            count[persons[i]] = (count[persons[i]] || 0) + 1;
            if (count[persons[i]] >= maxVotes) {
                maxVotes = count[persons[i]];
                currentLeader = persons[i];
            }
            this.leader.push(currentLeader);
        }
    }

    q(t) {
        let left = 0, right = this.times.length - 1;
        while (left < right) {
            const mid = Math.floor((left + right + 1) / 2);
            if (this.times[mid] <= t) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return this.leader[left];
    }
}