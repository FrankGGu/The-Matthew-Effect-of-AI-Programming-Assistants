function equalizeFrequency(s) {
    const freq = {};
    for (const c of s) {
        freq[c] = (freq[c] || 0) + 1;
    }

    const counts = Object.values(freq);
    for (let i = 0; i < counts.length; i++) {
        const temp = [...counts];
        temp[i]--;
        if (temp[i] === 0) temp.splice(i, 1);
        const set = new Set(temp);
        if (set.size === 1) return true;
    }

    return false;
}