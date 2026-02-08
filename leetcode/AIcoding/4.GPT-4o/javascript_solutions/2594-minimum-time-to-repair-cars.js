var repairCars = function(A, K) {
    let left = 1, right = Math.max(...A) * K;

    const canRepairAll = (time) => {
        let total = 0;
        for (let a of A) {
            total += Math.floor(time / a);
            if (total >= K) return true;
        }
        return total >= K;
    };

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (canRepairAll(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
};