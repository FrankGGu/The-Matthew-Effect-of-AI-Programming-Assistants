var countDaysTogether = function(arriveAlice, leaveAlice, arriveBob, leaveBob) {
    const daysInMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    function toDays(date) {
        const [month, day] = date.split('-').map(Number);
        let days = 0;
        for (let i = 1; i < month; i++) {
            days += daysInMonth[i];
        }
        days += day;
        return days;
    }

    const aliceArrive = toDays(arriveAlice);
    const aliceLeave = toDays(leaveAlice);
    const bobArrive = toDays(arriveBob);
    const bobLeave = toDays(leaveBob);

    const start = Math.max(aliceArrive, bobArrive);
    const end = Math.min(aliceLeave, bobLeave);

    return Math.max(0, end - start + 1);
};