function percentageLetter(s, letter) {
    const count = s.split('').filter(char => char === letter).length;
    return Math.floor((count / s.length) * 100);
}