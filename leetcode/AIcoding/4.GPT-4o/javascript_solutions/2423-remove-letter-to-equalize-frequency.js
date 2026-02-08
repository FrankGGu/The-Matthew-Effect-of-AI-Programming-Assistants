var equalFrequency = function(word) {
    const freq = {};
    for (const char of word) {
        freq[char] = (freq[char] || 0) + 1;
    }

    const counts = Object.values(freq);

    const check = (arr) => {
        const uniqueCounts = new Set(arr);
        if (uniqueCounts.size === 1) return true;
        if (uniqueCounts.size === 2) {
            const countArr = Array.from(uniqueCounts);
            const [a, b] = countArr;
            return (arr.filter(x => x === a).length === 1 && a - 1 === b) || 
                   (arr.filter(x => x === b).length === 1 && b - 1 === a);
        }
        return false;
    };

    for (let i = 0; i < counts.length; i++) {
        const newCounts = counts.slice();
        newCounts[i]--;
        if (newCounts[i] === 0) newCounts.splice(i, 1);
        if (check(newCounts)) return true;
    }

    return check(counts);
};