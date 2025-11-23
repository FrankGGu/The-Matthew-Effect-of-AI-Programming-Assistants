var minPeopleToTeach = function(n, languages, friendships) {
    const knowsLanguage = new Set();
    for (let i = 0; i < languages.length; i++) {
        for (const lang of languages[i]) {
            knowsLanguage.add(lang);
        }
    }

    const canCommunicate = new Array(n).fill(false);
    for (const [u, v] of friendships) {
        if (languages[u - 1].some(lang => languages[v - 1].includes(lang))) {
            canCommunicate[u - 1] = true;
            canCommunicate[v - 1] = true;
        }
    }

    let peopleToTeach = 0;
    for (let i = 0; i < n; i++) {
        if (!canCommunicate[i] && languages[i].length === 0) {
            peopleToTeach++;
        } else if (!canCommunicate[i] && languages[i].length > 0) {
            peopleToTeach++;
        }
    }

    return peopleToTeach;
};