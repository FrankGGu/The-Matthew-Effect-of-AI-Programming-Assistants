function minNumberOfFrogs(croak) {
    const map = new Map();
    map.set('c', 0);
    map.set('r', 1);
    map.set('a', 2);
    map.set('k', 3);
    map.set('o', 4);
    map.set('k', 5);

    const count = new Array(6).fill(0);
    let frogs = 0;
    let maxFrogs = 0;

    for (const ch of croak) {
        const index = map.get(ch);
        if (index === 0) {
            count[index]++;
            frogs++;
            maxFrogs = Math.max(maxFrogs, frogs);
        } else {
            if (count[index - 1] === 0) return -1;
            count[index - 1]--;
            count[index]++;
            if (index === 5) {
                frogs--;
            }
        }
    }

    for (let i = 0; i < 6; i++) {
        if (count[i] !== 0) return -1;
    }

    return maxFrogs;
}