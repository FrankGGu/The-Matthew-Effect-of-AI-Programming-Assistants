var avoidFlood = function(rains) {
    const n = rains.length;
    const ans = new Array(n).fill(1);
    const dryDays = [];
    const fullLakes = new Map();

    for (let i = 0; i < n; i++) {
        if (rains[i] > 0) {
            const lake = rains[i];
            if (fullLakes.has(lake)) {
                return [];
            }
            ans[i] = -1;
            fullLakes.set(lake, i);
        } else {
            dryDays.push(i);
        }
    }

    for (const [lake, rainedDay] of fullLakes) {
        let found = false;
        for (let i = 0; i < dryDays.length; i++) {
            if (dryDays[i] > rainedDay) {
                ans[dryDays[i]] = lake;
                dryDays.splice(i, 1);
                found = true;
                break;
            }
        }
        if (!found) {
            return [];
        }
    }

    for (const day of dryDays) {
        ans[day] = 1;
    }

    return ans;
};