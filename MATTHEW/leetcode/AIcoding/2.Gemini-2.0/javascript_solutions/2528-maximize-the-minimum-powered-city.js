var maxPower = function(stations, r, k) {
    let n = stations.length;
    let check = (power) => {
        let need = 0;
        let add = new Array(n).fill(0);
        let curr = 0;
        for (let i = 0; i < n; i++) {
            curr += (i > 0 ? add[i - 1] : 0);
            let total = stations[i] + curr;
            if (total < power) {
                let diff = power - total;
                need += diff;
                add[Math.min(n - 1, i + r)] += diff;
                curr += diff;
            }
        }
        return need <= k;
    };

    let left = Math.min(...stations);
    let right = Math.max(...stations) + k;
    while (left < right) {
        let mid = Math.floor((left + right + 1) / 2);
        if (check(mid)) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }
    return left;
};