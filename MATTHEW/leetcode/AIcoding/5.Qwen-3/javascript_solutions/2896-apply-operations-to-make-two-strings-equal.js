function canBeEqual(target, arr) {
    if (target.length !== arr.length) return false;
    const count = {};
    for (let i = 0; i < target.length; i++) {
        count[target[i]] = (count[target[i]] || 0) + 1;
        count[arr[i]] = (count[arr[i]] || 0) - 1;
    }
    for (const key in count) {
        if (count[key] !== 0) return false;
    }
    return true;
}