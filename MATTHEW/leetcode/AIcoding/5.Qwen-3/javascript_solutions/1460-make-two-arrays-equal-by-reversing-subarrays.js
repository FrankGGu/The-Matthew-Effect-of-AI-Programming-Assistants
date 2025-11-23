function canBeEqual(target, arr) {
    if (target.length !== arr.length) return false;
    const map = {};
    for (let i = 0; i < target.length; i++) {
        map[target[i]] = (map[target[i]] || 0) + 1;
        map[arr[i]] = (map[arr[i]] || 0) - 1;
    }
    for (const key in map) {
        if (map[key] !== 0) return false;
    }
    return true;
}