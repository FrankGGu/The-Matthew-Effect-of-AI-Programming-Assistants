function intersectionOfMultipleArrays(arrays) {
    if (arrays.length === 0) return [];

    const result = new Set(arrays[0]);

    for (let i = 1; i < arrays.length; i++) {
        const currentSet = new Set(arrays[i]);
        const temp = new Set();

        for (const num of result) {
            if (currentSet.has(num)) {
                temp.add(num);
            }
        }

        result.clear();
        for (const num of temp) {
            result.add(num);
        }
    }

    return Array.from(result).sort((a, b) => a - b);
}