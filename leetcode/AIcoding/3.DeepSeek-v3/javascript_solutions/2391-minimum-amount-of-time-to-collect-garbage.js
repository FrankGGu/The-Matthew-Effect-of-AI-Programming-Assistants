var garbageCollection = function(garbage, travel) {
    let time = 0;
    const lastM = garbage.reduce((last, _, i) => garbage[i].includes('M') ? i : last, -1);
    const lastP = garbage.reduce((last, _, i) => garbage[i].includes('P') ? i : last, -1);
    const lastG = garbage.reduce((last, _, i) => garbage[i].includes('G') ? i : last, -1);

    for (let i = 0; i < garbage.length; i++) {
        time += garbage[i].length;
        if (i < lastM) time += travel[i];
        if (i < lastP) time += travel[i];
        if (i < lastG) time += travel[i];
    }

    return time;
};