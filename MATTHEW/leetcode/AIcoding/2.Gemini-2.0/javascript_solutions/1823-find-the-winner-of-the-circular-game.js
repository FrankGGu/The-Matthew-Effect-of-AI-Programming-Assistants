var findTheWinner = function(n, k) {
    let people = Array.from({ length: n }, (_, i) => i + 1);
    let current = 0;

    while (people.length > 1) {
        current = (current + k - 1) % people.length;
        people.splice(current, 1);
    }

    return people[0];
};