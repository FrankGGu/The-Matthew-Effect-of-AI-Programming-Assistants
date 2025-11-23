function chalkReplacer(chalk, k) {
    const totalChalk = chalk.reduce((a, b) => a + b, 0);
    k %= totalChalk;

    for (let i = 0; i < chalk.length; i++) {
        if (k < chalk[i]) {
            return i;
        }
        k -= chalk[i];
    }
    return -1; // This line will never be reached
}