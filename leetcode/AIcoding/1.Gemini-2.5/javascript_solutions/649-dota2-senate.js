var predictPartyVictory = function(senate) {
    const n = senate.length;
    const radiantQueue = [];
    const direQueue = [];

    for (let i = 0; i < n; i++) {
        if (senate[i] === 'R') {
            radiantQueue.push(i);
        } else {
            direQueue.push(i);
        }
    }

    while (radiantQueue.length > 0 && direQueue.length > 0) {
        const rIdx = radiantQueue.shift();
        const dIdx = direQueue.shift();

        if (rIdx < dIdx) {
            // Radiant senator votes first, bans a Dire senator.
            // This Radiant senator survives to vote in the next round.
            radiantQueue.push(rIdx + n);
        } else {
            // Dire senator votes first, bans a Radiant senator.
            // This Dire senator survives to vote in the next round.
            direQueue.push(dIdx + n);
        }
    }

    return radiantQueue.length > 0 ? "Radiant" : "Dire";
};