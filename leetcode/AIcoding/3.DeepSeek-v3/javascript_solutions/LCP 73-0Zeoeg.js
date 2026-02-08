var adventureCamp = function(expeditions) {
    const initial = expeditions[0] ? expeditions[0].split('->') : [];
    const known = new Set(initial);
    let maxNew = -1;
    let result = -1;

    for (let i = 1; i < expeditions.length; i++) {
        const camps = expeditions[i].split('->').filter(camp => camp !== '');
        let newCamps = 0;
        const tempSet = new Set();

        for (const camp of camps) {
            if (!known.has(camp) && !tempSet.has(camp)) {
                newCamps++;
                tempSet.add(camp);
            }
        }

        if (newCamps > maxNew) {
            maxNew = newCamps;
            result = i;
        }

        for (const camp of tempSet) {
            known.add(camp);
        }
    }

    return result;
};