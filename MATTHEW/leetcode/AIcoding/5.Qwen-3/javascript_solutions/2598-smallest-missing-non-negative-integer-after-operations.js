function findSmallestInteger(nums) {
    const count = new Map();
    for (const num of nums) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    let i = 0;
    while (true) {
        if (!count.has(i)) {
            return i;
        }
        count.set(i, count.get(i) - 1);
        if (count.get(i) === 0) {
            count.delete(i);
        }
        i++;
    }
}