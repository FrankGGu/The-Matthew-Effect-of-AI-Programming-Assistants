class DSU {
    constructor(n) {
        this.parent = Array.from({ length: n }, (_, i) => i);
    }

    find(i) {
        if (this.parent[i] === i) {
            return i;
        }
        this.parent[i] = this.find(this.parent[i]);
        return this.parent[i];
    }

    union(i, j) {
        const rootI = this.find(i);
        const rootJ = this.find(j);
        if (rootI !== rootJ) {
            this.parent[rootJ] = rootI;
            return true;
        }
        return false;
    }
}

var findAllPeople = function(n, meetings, firstPerson) {
    const knownSecrets = new Set([0, firstPerson]);

    meetings.sort((a, b) => a[2] - b[2]);

    const groupedMeetings = new Map();
    for (const [p1, p2, time] of meetings) {
        if (!groupedMeetings.has(time)) {
            groupedMeetings.set(time, []);
        }
        groupedMeetings.get(time).push([p1, p2]);
    }

    for (const time of Array.from(groupedMeetings.keys()).sort((a, b) => a - b)) {
        const meetingsAtThisTime = groupedMeetings.get(time);
        const dsu = new DSU(n);
        const peopleInCurrentBlock = new Set();

        for (const [p1, p2] of meetingsAtThisTime) {
            dsu.union(p1, p2);
            peopleInCurrentBlock.add(p1);
            peopleInCurrentBlock.add(p2);
        }

        const rootsWithSecret = new Set();
        for (const person of peopleInCurrentBlock) {
            if (knownSecrets.has(person)) {
                rootsWithSecret.add(dsu.find(person));
            }
        }

        for (const person of peopleInCurrentBlock) {
            if (rootsWithSecret.has(dsu.find(person))) {
                knownSecrets.add(person);
            }
        }
    }

    return Array.from(knownSecrets);
};