var numberOfRounds = function(loginTime, logoutTime) {
    const parseTime = (time) => {
        const [hh, mm] = time.split(':').map(Number);
        return hh * 60 + mm;
    };

    let start = parseTime(loginTime);
    let end = parseTime(logoutTime);

    if (end < start) {
        end += 24 * 60;
    }

    start = Math.ceil(start / 15);
    end = Math.floor(end / 15);

    return Math.max(0, end - start);
};