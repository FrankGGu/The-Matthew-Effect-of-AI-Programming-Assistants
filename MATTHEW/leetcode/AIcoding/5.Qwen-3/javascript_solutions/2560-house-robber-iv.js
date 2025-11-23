function deleteAndEarn(nums) {
    const max = Math.max(...nums);
    const count = new Array(max + 1).fill(0);

    for (const num of nums) {
        count[num]++;
    }

    let prev = 0, curr = 0;
    for (let i = 1; i <= max; i++) {
        const temp = curr;
        curr = Math.max(curr, prev + i * count[i]);
        prev = temp;
    }

    return curr;
}