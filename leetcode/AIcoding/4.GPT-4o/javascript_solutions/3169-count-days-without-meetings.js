var countDaysTogether = function(arriveAlice, leaveAlice, arriveBob, leaveBob) {
    const startAlice = new Date(arriveAlice).getTime();
    const endAlice = new Date(leaveAlice).getTime();
    const startBob = new Date(arriveBob).getTime();
    const endBob = new Date(leaveBob).getTime();

    const start = Math.max(startAlice, startBob);
    const end = Math.min(endAlice, endBob);

    return Math.max(0, (end - start) / (1000 * 60 * 60 * 24) + 1);
};