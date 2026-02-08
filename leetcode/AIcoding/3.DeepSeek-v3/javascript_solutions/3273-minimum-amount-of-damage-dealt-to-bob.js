var minimumDamageDealtToBob = function(nums) {
    const n = nums.length;
    let minDamage = Infinity;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            for (let k = j + 1; k < n; k++) {
                const a = nums[i];
                const b = nums[j];
                const c = nums[k];
                if (a < b && b > c) {
                    const damage = a * b * c;
                    if (damage < minDamage) {
                        minDamage = damage;
                    }
                }
            }
        }
    }

    return minDamage === Infinity ? -1 : minDamage;
};