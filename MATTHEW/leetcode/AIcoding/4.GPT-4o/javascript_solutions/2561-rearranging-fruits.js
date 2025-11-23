function rearrangeFruits(fruits) {
    const n = fruits.length;
    const result = new Array(n);
    let j = 0;

    for (let i = 0; i < n; i += 2) {
        result[i] = fruits[j++];
    }

    for (let i = 1; i < n; i += 2) {
        result[i] = fruits[j++];
    }

    return result;
}