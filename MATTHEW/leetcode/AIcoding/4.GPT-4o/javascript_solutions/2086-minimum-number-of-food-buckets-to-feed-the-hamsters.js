function minFoodBuckets(hamsters) {
    const freq = {};
    for (const hamster of hamsters) {
        freq[hamster] = (freq[hamster] || 0) + 1;
    }

    let buckets = 0;
    for (const count of Object.values(freq)) {
        if (count > 2) {
            return -1;
        }
        buckets += Math.ceil(count / 2);
    }
    return buckets;
}