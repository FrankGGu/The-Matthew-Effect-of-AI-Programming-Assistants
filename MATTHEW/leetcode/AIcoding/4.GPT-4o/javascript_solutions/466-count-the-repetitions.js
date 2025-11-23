var getMaxRepetitions = function(s1, n1, s2, n2) {
    let map = new Map();
    let count1 = 0, count2 = 0, i = 0;

    while (count1 < n1) {
        if (!map.has(i)) {
            map.set(i, [count1, count2]);
        }
        let j = 0;
        while (i < s1.length && j < s2.length) {
            if (s1[i] === s2[j]) {
                j++;
            }
            i++;
        }
        count1++;
        count2 += j === s2.length ? 1 : 0;

        if (map.has(i)) {
            let [prevCount1, prevCount2] = map.get(i);
            let cycleCount1 = count1 - prevCount1;
            let cycleCount2 = count2 - prevCount2;
            let remainingCycles = Math.floor((n1 - count1) / cycleCount1);
            count1 += remainingCycles * cycleCount1;
            count2 += remainingCycles * cycleCount2;
        }
    }

    return Math.floor(count2 / n2);
};