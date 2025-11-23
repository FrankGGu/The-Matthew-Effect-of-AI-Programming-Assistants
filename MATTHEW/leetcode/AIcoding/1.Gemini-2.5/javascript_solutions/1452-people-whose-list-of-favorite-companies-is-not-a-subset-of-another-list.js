var peopleIndexes = function(favoriteCompanies) {
    const n = favoriteCompanies.length;
    const companySets = new Array(n);

    // Convert each person's list of favorite companies into a Set for efficient lookup
    for (let i = 0; i < n; i++) {
        companySets[i] = new Set(favoriteCompanies[i]);
    }

    const result = [];

    // Helper function to check if setA is a subset of setB
    const isSubset = (setA, setB) => {
        if (setA.size > setB.size) {
            return false;
        }
        for (let item of setA) {
            if (!setB.has(item)) {
                return false;
            }
        }
        return true;
    };

    // Iterate through each person
    for (let i = 0; i < n; i++) {
        let isNotSubsetOfAnyOther = true;
        // Compare current person's companies with every other person's companies
        for (let j = 0; j < n; j++) {
            // Skip comparing a person with themselves
            if (i === j) {
                continue;
            }

            // If current person's companies are a subset of another person's companies,
            // then this person's index should not be included in the result.
            if (isSubset(companySets[i], companySets[j])) {
                isNotSubsetOfAnyOther = false;
                break; // No need to check further, we found a superset
            }
        }

        // If after checking all other people, no one has a superset of current person's companies,
        // then add current person's index to the result.
        if (isNotSubsetOfAnyOther) {
            result.push(i);
        }
    }

    return result;
};