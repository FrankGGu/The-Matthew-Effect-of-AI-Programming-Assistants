function makeStringsEqual(s, target) {
    if (s === target) return true;
    const sHasOne = s.includes('1');
    const targetHasOne = target.includes('1');
    return sHasOne === targetHasOne;
}