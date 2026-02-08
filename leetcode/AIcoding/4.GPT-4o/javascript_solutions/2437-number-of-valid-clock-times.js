function countValidTimes(allowed) {
    let count = 0;
    for (let h = 0; h < 24; h++) {
        for (let m = 0; m < 60; m++) {
            let hourStr = String(h).padStart(2, '0');
            let minuteStr = String(m).padStart(2, '0');
            if (hourStr.split('').every(c => allowed.has(c)) && minuteStr.split('').every(c => allowed.has(c))) {
                count++;
            }
        }
    }
    return count;
}