function minDays(bloomed, m, k) {
    if (m * k > bloomed.length) return -1;

    function canMakeBouquets(days) {
        let bouquets = 0;
        let consecutive = 0;

        for (let i = 0; i < bloomed.length; i++) {
            if (bloomed[i] <= days) {
                consecutive++;
                if (consecutive === k) {
                    bouquets++;
                    consecutive = 0;
                }
            } else {
                consecutive = 0;
            }
        }

        return bouquets >= m;
    }

    let left = 1;
    let right = Math.max(...bloomed);
    let answer = -1;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (canMakeBouquets(mid)) {
            answer = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return answer;
}