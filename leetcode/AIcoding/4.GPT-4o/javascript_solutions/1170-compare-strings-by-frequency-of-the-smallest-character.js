var numSmallerByFrequency = function(queries, words) {
    const f = s => s.split('').sort().filter(c => c === s[0]).length;
    const wordFreqs = words.map(f).sort((a, b) => a - b);
    return queries.map(q => {
        const fq = f(q);
        return wordFreqs.filter(wf => wf > fq).length;
    });
};