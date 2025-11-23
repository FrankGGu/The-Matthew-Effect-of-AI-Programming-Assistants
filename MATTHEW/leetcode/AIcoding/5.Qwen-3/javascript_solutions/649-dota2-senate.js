function predictPartyVictory(senate) {
    const n = senate.length;
    const q = [];
    for (let i = 0; i < n; i++) {
        q.push(i);
    }

    while (q.length > 1) {
        const current = q.shift();
        const next = q[0];
        if (senate[current] === 'R' && senate[next] === 'D') {
            q.push(current);
        } else if (senate[current] === 'D' && senate[next] === 'R') {
            q.push(current);
        } else {
            q.push(current);
        }
    }

    return senate[q[0]] === 'R' ? 'Radiant' : 'Dire';
}