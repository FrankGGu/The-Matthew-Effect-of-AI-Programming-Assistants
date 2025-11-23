var reconstructQueue = function(people) {
    people.sort((a, b) => {
        if (a[0] !== b[0]) {
            return b[0] - a[0]; // Sort by height descending
        }
        return a[1] - b[1]; // If heights are equal, sort by k ascending
    });

    const result = [];
    for (const person of people) {
        result.splice(person[1], 0, person);
    }

    return result;
};