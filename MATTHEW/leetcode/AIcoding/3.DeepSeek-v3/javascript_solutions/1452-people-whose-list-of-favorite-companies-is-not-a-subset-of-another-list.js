var peopleIndexes = function(favoriteCompanies) {
    const n = favoriteCompanies.length;
    const res = [];
    for (let i = 0; i < n; i++) {
        let isSubset = false;
        for (let j = 0; j < n; j++) {
            if (i === j) continue;
            const set = new Set(favoriteCompanies[j]);
            const subset = favoriteCompanies[i].every(comp => set.has(comp));
            if (subset) {
                isSubset = true;
                break;
            }
        }
        if (!isSubset) {
            res.push(i);
        }
    }
    return res;
};