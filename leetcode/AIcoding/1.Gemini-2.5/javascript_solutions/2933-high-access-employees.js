var highAccessEmployees = function(accessTimes) {
    const employeeAccessMap = new Map();

    for (const [name, timeString] of accessTimes) {
        if (!employeeAccessMap.has(name)) {
            employeeAccessMap.set(name, []);
        }
        const hour = parseInt(timeString.substring(0, 2));
        const minute = parseInt(timeString.substring(3, 5));
        const totalMinutes = hour * 60 + minute;
        employeeAccessMap.get(name).push(totalMinutes);
    }

    const highAccess = [];

    for (const [name, times] of employeeAccessMap.entries()) {
        if (times.length < 3) {
            continue;
        }

        times.sort((a, b) => a - b);

        for (let i = 0; i <= times.length - 3; i++) {
            if (times[i + 2] - times[i] < 60) {
                highAccess.push(name);
                break; 
            }
        }
    }

    return highAccess;
};