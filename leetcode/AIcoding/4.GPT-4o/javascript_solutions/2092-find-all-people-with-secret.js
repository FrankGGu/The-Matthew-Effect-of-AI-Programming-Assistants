function findAllPeople(n, meetings, firstPerson) {
    const graph = Array.from({ length: n }, () => []);
    meetings.push([0, firstPerson, 0]);
    meetings.sort((a, b) => a[2] - b[2]);

    const unionFind = Array.from({ length: n }, (_, i) => i);

    const find = (x) => {
        if (unionFind[x] !== x) {
            unionFind[x] = find(unionFind[x]);
        }
        return unionFind[x];
    };

    const union = (x, y) => {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            unionFind[rootY] = rootX;
        }
    };

    const res = new Set([0, firstPerson]);
    let prevTime = 0;
    let currentPeople = new Set([0, firstPerson]);

    for (let i = 0; i < meetings.length; i++) {
        const [p1, p2, time] = meetings[i];
        if (time !== prevTime) {
            const currentArray = Array.from(currentPeople);
            for (let j = 0; j < currentArray.length; j++) {
                for (let k = j + 1; k < currentArray.length; k++) {
                    union(currentArray[j], currentArray[k]);
                }
            }
            if (currentArray.some(person => res.has(find(person)))) {
                for (let person of currentArray) {
                    res.add(find(person));
                }
            }
            currentPeople.clear();
            prevTime = time;
        }
        currentPeople.add(p1);
        currentPeople.add(p2);
        union(p1, p2);
    }

    return Array.from(res);
}