function minimizeOR(nums) {
    let result = 0;
    let maxOR = 0;

    for (const num of nums) {
        maxOR |= num;
    }

    for (const num of nums) {
        result |= (maxOR ^ num);
    }

    return result;
}