function canBeEqual(target, arr) {
    if (target.length !== arr.length) return false;
    const count = new Array(26).fill(0);
    for (let char of target) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }
    for (let char of arr) {
        count[char.charCodeAt(0) - 'a'.charCodeAt(0)]--;
    }
    return count.every(c => c === 0);
}