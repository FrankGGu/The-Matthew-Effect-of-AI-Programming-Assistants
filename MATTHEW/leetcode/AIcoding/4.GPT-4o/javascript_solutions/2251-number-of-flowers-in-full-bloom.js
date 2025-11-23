var numOfFlowersInFullBloom = function(flowers, people) {
    const bloom = new Array(flowers.length).fill(0);
    for (let i = 0; i < flowers.length; i++) {
        bloom[i] = [flowers[i][0], flowers[i][1]];
    }

    bloom.sort((a, b) => a[0] - b[0]);

    const result = new Array(people.length).fill(0);
    const events = [];

    for (let i = 0; i < bloom.length; i++) {
        events.push([bloom[i][0], 1]);
        events.push([bloom[i][1] + 1, -1]);
    }

    events.sort((a, b) => a[0] - b[0]);

    let count = 0;
    const prefixSum = new Array(events.length).fill(0);

    for (let i = 0; i < events.length; i++) {
        count += events[i][1];
        prefixSum[i] = count;
    }

    for (let i = 0; i < people.length; i++) {
        let left = 0;
        let right = events.length - 1;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (events[mid][0] <= people[i]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        result[i] = left === 0 ? 0 : prefixSum[left - 1];
    }

    return result;
};