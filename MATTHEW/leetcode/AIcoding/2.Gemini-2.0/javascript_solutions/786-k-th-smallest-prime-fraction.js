var kthSmallestPrimeFraction = function(arr, k) {
    const n = arr.length;
    let fractions = [];
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            fractions.push([arr[i], arr[j]]);
        }
    }

    fractions.sort((a, b) => (a[0] / a[1]) - (b[0] / b[1]));

    return fractions[k - 1];
};