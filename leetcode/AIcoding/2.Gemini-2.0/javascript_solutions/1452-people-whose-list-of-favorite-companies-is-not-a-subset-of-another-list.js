var peopleIndexes = function(favoriteCompanies) {
    const n = favoriteCompanies.length;
    const result = [];

    for (let i = 0; i < n; i++) {
        let isSubset = false;
        for (let j = 0; j < n; j++) {
            if (i === j) continue;

            if (isSubsetOf(favoriteCompanies[i], favoriteCompanies[j])) {
                isSubset = true;
                break;
            }
        }
        if (!isSubset) {
            result.push(i);
        }
    }

    return result;

    function isSubsetOf(list1, list2) {
        const set2 = new Set(list2);
        for (const company of list1) {
            if (!set2.has(company)) {
                return false;
            }
        }
        return true;
    }
};