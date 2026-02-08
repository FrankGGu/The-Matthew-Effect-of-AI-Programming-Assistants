function relativeSort(arr1, arr2) {
    const indexMap = new Map();
    for (let i = 0; i < arr2.length; i++) {
        indexMap.set(arr2[i], i);
    }

    return arr1.sort((a, b) => {
        const indexA = indexMap.has(a) ? indexMap.get(a) : Infinity;
        const indexB = indexMap.has(b) ? indexMap.get(b) : Infinity;
        return indexA - indexB;
    });
}