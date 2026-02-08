var numberOfBeams = function(bank) {
    let totalBeams = 0;
    let prevDevices = 0;

    for (const row of bank) {
        const currentDevices = row.split('').filter(cell => cell === '1').length;
        if (currentDevices > 0) {
            totalBeams += prevDevices * currentDevices;
            prevDevices = currentDevices;
        }
    }

    return totalBeams;
};