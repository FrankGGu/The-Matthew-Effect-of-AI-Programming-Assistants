var alertNames = function(keyTimes) {
    const timeToMinutes = (timeStr) => {
        const [hours, minutes] = timeStr.split(':').map(Number);
        return hours * 60 + minutes;
    };

    const employeeAccessTimes = new Map();

    for (const [name, time] of keyTimes) {
        if (!employeeAccessTimes.has(name)) {
            employeeAccessTimes.set(name, []);
        }
        employeeAccessTimes.get(name).push(timeToMinutes(time));
    }

    const alertedNames = new Set();

    for (const [name, times] of employeeAccessTimes.entries()) {
        times.sort((a, b) => a - b);

        if (times.length < 3) {
            continue;
        }

        for (let i = 0; i < times.length - 2; i++) {
            if (times[i + 2] - times[i] <= 60) {
                alertedNames.add(name);
                break;
            }
        }
    }

    const result = Array.from(alertedNames);
    result.sort();

    return result;
};