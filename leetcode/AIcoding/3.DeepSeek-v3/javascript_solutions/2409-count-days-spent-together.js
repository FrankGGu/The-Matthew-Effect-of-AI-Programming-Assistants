var countDaysTogether = function(arriveAlice, leaveAlice, arriveBob, leaveBob) {
    const months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    const getDayOfYear = (date) => {
        const [month, day] = date.split('-').map(Number);
        let dayOfYear = 0;
        for (let i = 0; i < month - 1; i++) {
            dayOfYear += months[i];
        }
        dayOfYear += day;
        return dayOfYear;
    };

    const aliceArrive = getDayOfYear(arriveAlice);
    const aliceLeave = getDayOfYear(leaveAlice);
    const bobArrive = getDayOfYear(arriveBob);
    const bobLeave = getDayOfYear(leaveBob);

    const start = Math.max(aliceArrive, bobArrive);
    const end = Math.min(aliceLeave, bobLeave);

    return Math.max(0, end - start + 1);
};