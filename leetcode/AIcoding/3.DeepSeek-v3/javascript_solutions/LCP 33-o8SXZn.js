var storeWater = function(bucket, vat) {
    let maxK = Math.max(...vat);
    if (maxK === 0) {
        return 0;
    }
    let res = Infinity;
    for (let k = 1; k <= maxK; k++) {
        let t = 0;
        for (let i = 0; i < bucket.length; i++) {
            t += Math.max(0, Math.ceil(vat[i] / k) - bucket[i]);
        }
        res = Math.min(res, t + k);
    }
    return res;
};