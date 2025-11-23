function numRabbits(buckets) {
    const count = {};
    let total = 0;
    for (const k of buckets) {
        if (!count[k]) {
            count[k] = 1;
            total += k + 1;
        } else {
            count[k]++;
            if (count[k] === k + 1) {
                count[k] = 0;
            }
        }
    }
    return total;
}