function balancedStringSplit(s) {
    let count = 0, balancedCount = 0;
    for (const char of s) {
        count += char === 'L' ? 1 : -1;
        if (count === 0) balancedCount++;
    }
    return balancedCount;
}