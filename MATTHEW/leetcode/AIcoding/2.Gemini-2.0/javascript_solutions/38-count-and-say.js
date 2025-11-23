var countAndSay = function(n) {
    if (n === 1) {
        return "1";
    }

    let prev = "1";
    for (let i = 2; i <= n; i++) {
        let current = "";
        let count = 1;
        for (let j = 0; j < prev.length; j++) {
            if (j + 1 < prev.length && prev[j] === prev[j + 1]) {
                count++;
            } else {
                current += count.toString() + prev[j];
                count = 1;
            }
        }
        prev = current;
    }

    return prev;
};