function findLatestGroup(grp, m) {
    const count = {};
    for (const g of grp) {
        count[g] = (count[g] || 0) + 1;
    }
    let latest = -1;
    for (const [g, c] of Object.entries(count)) {
        if (c === m) {
            latest = Math.max(latest, Number(g));
        }
    }
    return latest;
}