var sortPeople = function(names, heights) {
    const people = [];
    for (let i = 0; i < names.length; i++) {
        people.push({ name: names[i], height: heights[i] });
    }

    people.sort((a, b) => b.height - a.height);

    const sortedNames = [];
    for (let i = 0; i < people.length; i++) {
        sortedNames.push(people[i].name);
    }

    return sortedNames;
};