var numFriendRequests = function(ages) {
    const freq = new Array(121).fill(0);
    for (const age of ages) {
        freq[age]++;
    }

    let totalRequests = 0;

    for (let ageA = 1; ageA <= 120; ageA++) {
        for (let ageB = 1; ageB <= 120; ageB++) {
            if (freq[ageA] === 0 || freq[ageB] === 0) {
                continue;
            }

            // Conditions for A to send a friend request to B:
            // 1. ageB > 0.5 * ageA + 7
            // 2. ageB <= ageA
            // (The third condition "!(ageB > 100 && ageA < 100)" is implicitly satisfied
            // by the first two for ages between 1 and 120)
            if (ageB > 0.5 * ageA + 7 && ageB <= ageA) {
                if (ageA === ageB) {
                    // If A and B have the same age, and a person does not send a request to themself,
                    // then for each of the freq[ageA] people, they can send a request to freq[ageA] - 1 other people.
                    totalRequests += freq[ageA] * (freq[ageA] - 1);
                } else {
                    // If A and B have different ages, all freq[ageA] people can send requests to all freq[ageB] people.
                    totalRequests += freq[ageA] * freq[ageB];
                }
            }
        }
    }

    return totalRequests;
};