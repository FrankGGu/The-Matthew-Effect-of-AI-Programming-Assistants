function canMakeEqual(target, arr) {
    if (target.length !== arr.length) return false;
    let targetBits = 0;
    let arrBits = 0;
    for (let i = 0; i < target.length; i++) {
        targetBits |= target.charCodeAt(i);
        arrBits |= arr.charCodeAt(i);
    }
    return targetBits === arrBits;
}