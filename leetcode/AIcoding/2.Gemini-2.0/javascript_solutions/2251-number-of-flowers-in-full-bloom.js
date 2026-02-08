var fullBloomFlowers = function(flowers, people) {
    const start = [];
    const end = [];
    for (const [s, e] of flowers) {
        start.push(s);
        end.push(e + 1);
    }
    start.sort((a, b) => a - b);
    end.sort((a, b) => a - b);

    const ans = [];
    for (const p of people) {
        let i = 0;
        let j = 0;
        let l = 0;
        let r = start.length - 1;
        while (l <= r) {
            const mid = Math.floor((l + r) / 2);
            if (start[mid] <= p) {
                i = mid + 1;
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }

        l = 0;
        r = end.length - 1;
        while (l <= r) {
            const mid = Math.floor((l + r) / 2);
            if (end[mid] <= p) {
                j = mid + 1;
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }
        ans.push(i - j);
    }

    return ans;
};