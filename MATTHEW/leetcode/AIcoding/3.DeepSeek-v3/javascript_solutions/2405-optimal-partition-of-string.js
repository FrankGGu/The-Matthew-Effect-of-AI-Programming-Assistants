var partitionString = function(s) {
    let lastSeen = new Array(26).fill(-1);
    let count = 1;
    let start = 0;

    for (let i = 0; i < s.length; i++) {
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        if (lastSeen[charCode] >= start) {
            count++;
            start = i;
        }
        lastSeen[charCode] = i;
    }

    return count;
};