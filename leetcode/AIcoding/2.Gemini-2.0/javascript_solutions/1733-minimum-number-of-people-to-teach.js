var minimumTeachings = function(n, languages, friendships) {
    const adj = new Array(n + 1).fill(null).map(() => new Set());

    for (let i = 0; i < languages.length; i++) {
        for (const lang of languages[i]) {
            adj[lang].add(i + 1);
        }
    }

    const needToTeach = new Set();

    for (const [u, v] of friendships) {
        let canCommunicate = false;
        for (const lang of languages[u - 1]) {
            if (languages[v - 1].includes(lang)) {
                canCommunicate = true;
                break;
            }
        }
        if (!canCommunicate) {
            needToTeach.add(u);
            needToTeach.add(v);
        }
    }

    let minPeople = Infinity;
    for (let i = 1; i <= n; i++) {
        let peopleToTeach = new Set();
        for (const person of needToTeach) {
            if (!languages[person - 1].includes(i)) {
                peopleToTeach.add(person);
            }
        }
        minPeople = Math.min(minPeople, peopleToTeach.size);
    }

    return minPeople;
};