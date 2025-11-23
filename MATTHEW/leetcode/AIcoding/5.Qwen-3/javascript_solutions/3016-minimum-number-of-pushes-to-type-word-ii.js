function minimumPushes(word) {
    const freq = {};
    for (const c of word) {
        freq[c] = (freq[c] || 0) + 1;
    }

    const counts = Object.values(freq).sort((a, b) => b - a);

    let pushes = 0;
    for (let i = 0; i < counts.length; i++) {
        pushes += counts[i] * Math.floor((i) / 8) + 1;
    }

    return pushes;
}