var partitionLabels = function(s) {
    const lastOccurrence = new Array(26);
    for (let i = 0; i < s.length; i++) {
        lastOccurrence[s.charCodeAt(i) - 'a'.charCodeAt(0)] = i;
    }

    const result = [];
    let start = 0;
    let end = 0;

    for (let i = 0; i < s.length; i++) {
        end = Math.max(end, lastOccurrence[s.charCodeAt(i) - 'a'.charCodeAt(0)]);
        if (i === end) {
            result.push(end - start + 1);
            start = i + 1;
        }
    }

    return result;
};