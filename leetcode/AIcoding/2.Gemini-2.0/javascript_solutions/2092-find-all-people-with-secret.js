var findAllPeople = function(n, meetings, firstPerson) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [x, y, time] of meetings) {
        adj[x].push([y, time]);
        adj[y].push([x, time]);
    }

    const known = new Array(n).fill(false);
    known[0] = true;
    known[firstPerson] = true;

    meetings.sort((a, b) => a[2] - b[2]);

    let i = 0;
    while (i < meetings.length) {
        let j = i;
        const currentGroup = new Set();
        const currentKnown = new Set();

        while (j < meetings.length && meetings[j][2] === meetings[i][2]) {
            const [x, y, time] = meetings[j];
            if (known[x]) {
                currentKnown.add(x);
            }
            if (known[y]) {
                currentKnown.add(y);
            }
            currentGroup.add(x);
            currentGroup.add(y);
            j++;
        }

        for (const person of currentGroup) {
            if (currentKnown.has(person)) {
                currentKnown.add(person);
            } else {
                for(const knownPerson of currentKnown){
                    if(adj[person].some(neighbor => neighbor[0] === knownPerson && neighbor[1] === meetings[i][2])){
                        currentKnown.add(person);
                        break;
                    }
                }
            }
        }

        for (const person of currentKnown) {
            known[person] = true;
        }
        i = j;
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        if (known[i]) {
            result.push(i);
        }
    }

    return result;
};