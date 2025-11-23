var minimumTeachings = function(n, languages, friendships) {
    const personLanguageSets = new Array(n);
    for (let i = 0; i < n; i++) {
        personLanguageSets[i] = new Set(languages[i]);
    }

    const hasCommonLanguage = (person1Id, person2Id) => {
        const set1 = personLanguageSets[person1Id];
        const set2 = personLanguageSets[person2Id];
        for (const lang of set1) {
            if (set2.has(lang)) {
                return true;
            }
        }
        return false;
    };

    const peopleToConsider = new Set();
    for (const [u, v] of friendships) {
        const personU = u - 1;
        const personV = v - 1;

        if (!hasCommonLanguage(personU, personV)) {
            peopleToConsider.add(personU);
            peopleToConsider.add(personV);
        }
    }

    if (peopleToConsider.size === 0) {
        return 0;
    }

    let minTeachings = Infinity;

    for (let lang = 1; lang <= 100; lang++) {
        let currentTeachings = 0;
        for (const personId of peopleToConsider) {
            if (!personLanguageSets[personId].has(lang)) {
                currentTeachings++;
            }
        }
        minTeachings = Math.min(minTeachings, currentTeachings);
    }

    return minTeachings;
};