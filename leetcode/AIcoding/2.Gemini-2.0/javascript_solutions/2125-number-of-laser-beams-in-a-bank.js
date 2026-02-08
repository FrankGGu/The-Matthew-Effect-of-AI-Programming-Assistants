var numberOfBeams = function(bank) {
    let prevDevices = 0;
    let totalBeams = 0;
    for (let row of bank) {
        let currentDevices = 0;
        for (let char of row) {
            if (char === '1') {
                currentDevices++;
            }
        }
        if (currentDevices > 0) {
            totalBeams += prevDevices * currentDevices;
            prevDevices = currentDevices;
        }
    }
    return totalBeams;
};