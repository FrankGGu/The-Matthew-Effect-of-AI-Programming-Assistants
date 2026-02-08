function canEnter(people) {
    let totalWeight = 0;
    for (let i = 0; i < people.length; i++) {
        totalWeight += people[i];
    }
    return totalWeight <= 200;
}