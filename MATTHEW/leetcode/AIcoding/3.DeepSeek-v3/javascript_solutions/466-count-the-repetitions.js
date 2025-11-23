var getMaxRepetitions = function(s1, n1, s2, n2) {
    let indexMap = new Map();
    let count1 = 0, count2 = 0, index = 0;
    while (count1 < n1) {
        for (let i = 0; i < s1.length; i++) {
            if (s1[i] === s2[index]) {
                index++;
                if (index === s2.length) {
                    index = 0;
                    count2++;
                }
            }
        }
        count1++;
        if (indexMap.has(index)) {
            let [prevCount1, prevCount2] = indexMap.get(index);
            let cycleCount1 = count1 - prevCount1;
            let cycleCount2 = count2 - prevCount2;
            let cycles = Math.floor((n1 - prevCount1) / cycleCount1);
            count2 = prevCount2 + cycles * cycleCount2;
            count1 = prevCount1 + cycles * cycleCount1;
        } else {
            indexMap.set(index, [count1, count2]);
        }
    }
    return Math.floor(count2 / n2);
};