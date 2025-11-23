function isPrefixString(nums, s) {
    let prefix = '';
    for (const str of nums) {
        prefix += str;
        if (prefix === s) {
            return true;
        }
    }
    return false;
}