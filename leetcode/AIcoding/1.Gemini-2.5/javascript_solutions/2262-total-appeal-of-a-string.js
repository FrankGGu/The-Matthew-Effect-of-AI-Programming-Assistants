var appealSum = function(s) {
    let n = s.length;
    let totalAppeal = 0;
    let lastSeen = new Array(26).fill(-1);

    for (let i = 0; i < n; i++) {
        let charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        let prevIndex = lastSeen[charCode];

        totalAppeal += (i - prevIndex) * (n - i);

        lastSeen[charCode] = i;
    }

    return totalAppeal;
};