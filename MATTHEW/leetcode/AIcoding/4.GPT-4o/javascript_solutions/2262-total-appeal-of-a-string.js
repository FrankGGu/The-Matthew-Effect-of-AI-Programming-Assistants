var appealSum = function(s) {
    let totalAppeal = 0;
    let lastSeen = new Array(26).fill(-1);

    for (let i = 0; i < s.length; i++) {
        const charIndex = s.charCodeAt(i) - 'a'.charCodeAt(0);
        totalAppeal += (i - lastSeen[charIndex]) * (s.length - i);
        lastSeen[charIndex] = i;
    }

    return totalAppeal;
};