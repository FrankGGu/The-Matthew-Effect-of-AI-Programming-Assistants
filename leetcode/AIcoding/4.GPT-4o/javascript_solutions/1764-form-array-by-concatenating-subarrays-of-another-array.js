function concatenate(nums, groups) {
    let result = [];
    for (let i = 0; i < groups.length; i++) {
        let start = groups[i][0];
        let end = groups[i][1];
        result = result.concat(nums.slice(start, end + 1));
    }
    return result;
}