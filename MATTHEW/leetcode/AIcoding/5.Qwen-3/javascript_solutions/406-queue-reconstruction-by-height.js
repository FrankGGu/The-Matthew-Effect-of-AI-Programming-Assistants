function reconstructQueue(people) {
    people.sort((a, b) => {
        if (b[0] !== a[0]) {
            return b[0] - a[0];
        } else {
            return a[1] - b[1];
        }
    });
    const result = [];
    for (let i = 0; i < people.length; i++) {
        result.splice(people[i][1], 0, people[i]);
    }
    return result;
}