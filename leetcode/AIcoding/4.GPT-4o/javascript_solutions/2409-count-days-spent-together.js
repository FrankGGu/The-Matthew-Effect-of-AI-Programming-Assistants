var countDaysTogether = function(arriveAlice, leaveAlice, arriveBob, leaveBob) {
    const startAlice = new Date(arriveAlice);
    const endAlice = new Date(leaveAlice);
    const startBob = new Date(arriveBob);
    const endBob = new Date(leaveBob);

    const start = new Date(Math.max(startAlice, startBob));
    const end = new Date(Math.min(endAlice, endBob));

    const daysSpentTogether = Math.max(0, (end - start) / (1000 * 60 * 60 * 24) + 1);

    return daysSpentTogether;
};