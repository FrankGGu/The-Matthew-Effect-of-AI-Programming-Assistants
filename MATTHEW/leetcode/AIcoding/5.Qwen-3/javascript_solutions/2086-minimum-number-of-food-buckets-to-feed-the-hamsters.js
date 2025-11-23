function minFoodBuckets(street) {
    let n = street.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        if (street[i] === 'H') {
            if (i + 1 < n && street[i + 1] === 'H') {
                count++;
                i += 2;
            } else {
                count++;
                i++;
            }
        }
    }
    return count;
}