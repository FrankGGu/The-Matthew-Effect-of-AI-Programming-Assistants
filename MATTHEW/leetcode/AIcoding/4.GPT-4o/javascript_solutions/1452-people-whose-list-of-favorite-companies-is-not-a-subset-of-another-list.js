var peopleNotSubset = function(favoriteCompanies) {
    const result = [];
    const set = new Set();

    for (const companies of favoriteCompanies) {
        const sorted = companies.slice().sort().join(',');
        set.add(sorted);
    }

    for (const companies of favoriteCompanies) {
        const sorted = companies.slice().sort().join(',');
        let isSubset = false;

        for (const other of favoriteCompanies) {
            if (sorted !== other.slice().sort().join(',') && other.every(company => companies.includes(company))) {
                isSubset = true;
                break;
            }
        }

        if (!isSubset) {
            result.push(companies);
        }
    }

    return result;
};