function peopleWhoLoveYourCompany(favoriteCompanies) {
    const n = favoriteCompanies.length;
    const result = [];

    for (let i = 0; i < n; i++) {
        let isSubset = false;
        for (let j = 0; j < n; j++) {
            if (i !== j) {
                const setA = new Set(favoriteCompanies[i]);
                const setB = new Set(favoriteCompanies[j]);
                let isSubsetOf = true;
                for (const company of setA) {
                    if (!setB.has(company)) {
                        isSubsetOf = false;
                        break;
                    }
                }
                if (isSubsetOf) {
                    isSubset = true;
                    break;
                }
            }
        }
        if (!isSubset) {
            result.push(i);
        }
    }

    return result;
}