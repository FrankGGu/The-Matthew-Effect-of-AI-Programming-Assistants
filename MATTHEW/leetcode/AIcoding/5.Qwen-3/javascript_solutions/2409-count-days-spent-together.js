function countDaysTogether(arriveAlice, leaveAlice, arriveBob, leaveBob) {
    const monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    function dateToDayOfYear(date) {
        const [month, day] = date.split('/').map(Number);
        let dayOfYear = 0;
        for (let i = 0; i < month - 1; i++) {
            dayOfYear += monthDays[i];
        }
        dayOfYear += day;
        return dayOfYear;
    }

    const aStart = dateToDayOfYear(arriveAlice);
    const aEnd = dateToDayOfYear(leaveAlice);
    const bStart = dateToDayOfYear(arriveBob);
    const bEnd = dateToDayOfYear(leaveBob);

    const overlapStart = Math.max(aStart, bStart);
    const overlapEnd = Math.min(aEnd, bEnd);

    return Math.max(0, overlapEnd - overlapStart + 1);
}