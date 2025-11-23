function earliestSecond(nums, start, goal) {
    const n = nums.length;
    const map = new Map();
    for (let i = 0; i < n; i++) {
        if (!map.has(nums[i])) {
            map.set(nums[i], []);
        }
        map.get(nums[i]).push(i);
    }

    let time = 0;
    let current = start;
    while (true) {
        if (current === goal) return time;
        const positions = map.get(nums[current]);
        if (!positions) return -1;
        const nextPositions = [];
        for (const pos of positions) {
            if (pos !== current) {
                nextPositions.push(pos);
            }
        }
        if (nextPositions.length === 0) return -1;
        current = nextPositions[0];
        time++;
    }
}