var minimumTeachings = function(n, languages, friendships) {
    const m = languages.length;
    const cantCommunicate = new Set();

    for (const [u, v] of friendships) {
        const langU = new Set(languages[u - 1]);
        const langV = new Set(languages[v - 1]);
        let canCommunicate = false;
        for (const l of langU) {
            if (langV.has(l)) {
                canCommunicate = true;
                break;
            }
        }
        if (!canCommunicate) {
            cantCommunicate.add(u - 1);
            cantCommunicate.add(v - 1);
        }
    }

    if (cantCommunicate.size === 0) return 0;

    let minTeach = Infinity;
    for (let l = 1; l <= n; l++) {
        let teachCount = 0;
        for (const person of cantCommunicate) {
            if (!languages[person].includes(l)) {
                teachCount++;
            }
        }
        minTeach = Math.min(minTeach, teachCount);
    }

    return minTeach;
};