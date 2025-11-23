var beautifulBouquet = function(flowers, cnt) {
    const MOD = 1e9 + 7;
    let res = 0;
    let left = 0;
    const freq = {};

    for (let right = 0; right < flowers.length; right++) {
        const flower = flowers[right];
        freq[flower] = (freq[flower] || 0) + 1;

        while (freq[flower] > cnt) {
            const leftFlower = flowers[left];
            freq[leftFlower]--;
            if (freq[leftFlower] === 0) {
                delete freq[leftFlower];
            }
            left++;
        }

        res = (res + right - left + 1) % MOD;
    }

    return res;
};