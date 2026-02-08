var maximumBeauty = function(flowers, newFlowers, target, full, partial) {
    flowers.sort((a, b) => a - b);
    const n = flowers.length;
    let sum = 0;
    for (let i = 0; i < n; i++) {
        sum += flowers[i];
    }

    let ans = 0;
    for (let numFull = 0; numFull <= n; numFull++) {
        let remainingFlowers = newFlowers;
        let currentBeauty = numFull * full;

        if (numFull > 0) {
            let need = 0;
            for (let i = n - numFull; i < n; i++) {
                need += Math.max(0, target - flowers[i]);
            }
            if (need > newFlowers) {
                continue;
            }
            remainingFlowers -= need;
        }

        let left = 0;
        let right = n - numFull -1;

        if (right < 0) {
            ans = Math.max(ans, currentBeauty);
            continue;
        }

        let low = 0;
        let high = target;
        let bestPartial = 0;

        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            let need = 0;
            for (let i = 0; i <= right; i++) {
                need += Math.max(0, mid - flowers[i]);
            }

            if (need <= remainingFlowers) {
                bestPartial = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        currentBeauty += bestPartial * partial;
        ans = Math.max(ans, currentBeauty);
    }

    return ans;
};