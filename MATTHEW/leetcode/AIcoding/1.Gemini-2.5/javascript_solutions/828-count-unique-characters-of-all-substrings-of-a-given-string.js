var uniqueLetterString = function(s) {
    const n = s.length;
    const charPositions = new Array(26).fill(0).map(() => []);

    for (let i = 0; i < 26; i++) {
        charPositions[i].push(-1);
    }

    for (let i = 0; i < n; i++) {
        const charCode = s.charCodeAt(i) - 'A'.charCodeAt(0);
        charPositions[charCode].push(i);
    }

    for (let i = 0; i < 26; i++) {
        charPositions[i].push(n);
    }

    let totalUniqueCount = 0;

    for (let i = 0; i < 26; i++) {
        const positions = charPositions[i];
        for (let j = 1; j < positions.length - 1; j++) {
            const currentIdx = positions[j];
            const prevIdx = positions[j - 1];
            const nextIdx = positions[j + 1];

            const leftChoices = currentIdx - prevIdx;
            const rightChoices = nextIdx - currentIdx;

            totalUniqueCount += leftChoices * rightChoices;
        }
    }

    return totalUniqueCount;
};