var chalkReplacer = function(chalk, k) {
    let sumChalk = 0;
    for (let i = 0; i < chalk.length; i++) {
        sumChalk += chalk[i];
    }

    k %= sumChalk;

    for (let i = 0; i < chalk.length; i++) {
        if (k < chalk[i]) {
            return i;
        }
        k -= chalk[i];
    }

    return -1; // Should not be reached based on problem constraints
};