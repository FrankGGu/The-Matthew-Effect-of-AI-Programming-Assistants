var findOriginalArray = function(changed) {
    if (changed.length % 2 !== 0) return [];
    const count = {};
    for (const num of changed) {
        count[num] = (count[num] || 0) + 1;
    }
    const original = [];
    const keys = Object.keys(count).map(Number).sort((a, b) => a - b);
    for (const num of keys) {
        if (count[num] > count[num * 2] || count[num] === 0) return [];
        for (let i = 0; i < count[num]; i++) {
            original.push(num);
        }
        count[num * 2] -= count[num];
        count[num] = 0;
    }
    return original;
};