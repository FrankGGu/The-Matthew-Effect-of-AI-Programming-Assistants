function recoverArray(changed) {
    const n = changed.length;
    if (n % 2 !== 0) return [];

    changed.sort((a, b) => a - b);
    const original = [];
    const count = new Map();

    for (const num of changed) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    for (const num of changed) {
        if (count.get(num) === 0) continue;

        const doubled = num * 2;
        if (!count.has(doubled) || count.get(doubled) === 0) return [];

        original.push(num);
        count.set(num, count.get(num) - 1);
        count.set(doubled, count.get(doubled) - 1);
    }

    return original;
}