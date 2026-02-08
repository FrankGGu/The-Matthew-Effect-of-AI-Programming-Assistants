var sortPeople = function(names, heights) {
    const people = names.map((name, index) => ({ name, height: heights[index] }));
    people.sort((a, b) => b.height - a.height);
    return people.map(person => person.name);
};