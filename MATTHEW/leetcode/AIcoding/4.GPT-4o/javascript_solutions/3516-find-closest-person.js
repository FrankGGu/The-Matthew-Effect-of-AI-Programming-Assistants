function findClosestPerson(people, target) {
    let closest = null;
    let minDistance = Infinity;

    for (const person of people) {
        const distance = Math.abs(person - target);
        if (distance < minDistance) {
            minDistance = distance;
            closest = person;
        }
    }

    return closest;
}