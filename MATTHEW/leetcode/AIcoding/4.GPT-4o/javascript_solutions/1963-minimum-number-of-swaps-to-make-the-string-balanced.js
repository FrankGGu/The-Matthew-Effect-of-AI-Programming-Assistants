function minSwaps(s) {
    let left = 0, right = 0;
    for (const char of s) {
        if (char === '[') left++;
        else right++;
    }
    if (left !== right) return -1;
    let balance = 0, maxBalance = 0;
    for (const char of s) {
        if (char === '[') balance++;
        else balance--;
        maxBalance = Math.min(maxBalance, balance);
    }
    return Math.ceil(-maxBalance / 2);
}