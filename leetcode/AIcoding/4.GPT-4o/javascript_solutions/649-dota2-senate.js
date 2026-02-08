var predictPartyVictory = function(senate) {
    let rCount = 0, dCount = 0, rQueue = [], dQueue = [];

    for (let i = 0; i < senate.length; i++) {
        if (senate[i] === 'R') {
            rCount++;
            rQueue.push(i);
        } else {
            dCount++;
            dQueue.push(i);
        }
    }

    while (rCount > 0 && dCount > 0) {
        if (rQueue[0] < dQueue[0]) {
            rQueue.push(rQueue.shift() + senate.length);
            dCount--;
        } else {
            dQueue.push(dQueue.shift() + senate.length);
            rCount--;
        }
    }

    return rCount > 0 ? "Radiant" : "Dire";
};