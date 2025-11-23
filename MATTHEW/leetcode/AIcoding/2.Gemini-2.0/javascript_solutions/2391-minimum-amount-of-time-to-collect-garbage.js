var garbageCollection = function(garbage, travel) {
    let lastG = -1, lastP = -1, lastM = -1;
    let totalG = 0, totalP = 0, totalM = 0;
    let n = garbage.length;

    for (let i = 0; i < n; i++) {
        let s = garbage[i];
        for (let j = 0; j < s.length; j++) {
            if (s[j] === 'G') {
                totalG++;
                lastG = i;
            } else if (s[j] === 'P') {
                totalP++;
                lastP = i;
            } else {
                totalM++;
                lastM = i;
            }
        }
    }

    let travelG = 0, travelP = 0, travelM = 0;
    for (let i = 0; i < n - 1; i++) {
        if (i < lastG) {
            travelG += travel[i];
        }
        if (i < lastP) {
            travelP += travel[i];
        }
        if (i < lastM) {
            travelM += travel[i];
        }
    }

    return totalG + totalP + totalM + travelG + travelP + travelM;
};