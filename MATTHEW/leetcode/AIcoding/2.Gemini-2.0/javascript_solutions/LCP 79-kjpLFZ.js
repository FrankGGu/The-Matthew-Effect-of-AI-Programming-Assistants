var extractSpells = function(spells, charms) {
    const charmSet = new Set(charms);
    let result = "";

    for (let spell of spells) {
        if (charmSet.has(spell)) {
            result += spell;
        }
    }

    return result;
};