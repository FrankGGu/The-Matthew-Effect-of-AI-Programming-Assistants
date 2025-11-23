var numberOfBeams = function(bank) {
    let prevCount = 0;
    let totalBeams = 0;

    for (const row of bank) {
        const currentCount = (row.match(/1/g) || []).length;
        if (currentCount === 0) continue;

        totalBeams += prevCount * currentCount;
        prevCount = currentCount;
    }

    return totalBeams;
};