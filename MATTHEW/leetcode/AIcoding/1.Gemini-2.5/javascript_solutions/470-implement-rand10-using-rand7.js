var rand10 = function() {
    while (true) {
        let row = rand7();
        let col = rand7();
        // Calculate a number in the range [1, 49]
        let num = (row - 1) * 7 + col;

        // If num is in the range [1, 40], we can use it
        if (num <= 40) {
            // Map [1, 40] to [1, 10]
            return (num - 1) % 10 + 1;
        }
        // If num is in [41, 49], we reject and retry.
        // To optimize, we can try to use the remaining numbers [41, 49]
        // to generate another set of numbers if the range is large enough.
        // For this problem, a simple rejection of [41, 49] is sufficient.

        // Advanced optimization (not strictly required for typical solutions but good to know):
        // If num is in [41, 49], we have 9 numbers. We can use rand7() again
        // to get a range of 63 numbers (9 * 7).
        // Let num2 = (num - 40 - 1) * 7 + rand7(); // num - 40 gives [1,9]
        // This would create a range [1, 63]. We can then take [1, 60]
        // and return (num2 - 1) % 10 + 1.
        // However, the simpler rejection of [41, 49] is more common and accepted.
    }
};