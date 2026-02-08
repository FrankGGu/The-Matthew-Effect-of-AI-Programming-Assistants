var makeStringsEqual = function(s, target) {
    if (s === target) return true;
    const hasOneInS = s.includes('1');
    const hasOneInTarget = target.includes('1');
    return hasOneInS === hasOneInTarget;
};