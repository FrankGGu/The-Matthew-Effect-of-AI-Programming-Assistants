function groupThePeople(people) {
    const groups = {};
    const result = [];

    for (let i = 0; i < people.length; i++) {
        const key = people[i];
        if (!groups[key]) {
            groups[key] = [];
        }
        groups[key].push(i);
        if (groups[key].length === key) {
            result.push([...groups[key]]);
            groups[key] = [];
        }
    }

    return result;
}