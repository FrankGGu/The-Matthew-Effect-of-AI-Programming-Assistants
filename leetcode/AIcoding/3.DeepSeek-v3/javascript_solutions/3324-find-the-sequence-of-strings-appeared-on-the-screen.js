var splitMessage = function(message, limit) {
    const n = message.length;
    let parts = 0;
    let result = [];

    for (let k = 1; k <= n; k++) {
        let total = 0;
        const suffixLen = String(k).length * 2 + 3;
        if (suffixLen >= limit) break;

        let possible = true;
        let current = 0;
        let temp = [];

        for (let i = 1; i <= k; i++) {
            const partSuffix = `<${i}/${k}>`;
            const available = limit - partSuffix.length;
            if (available <= 0) {
                possible = false;
                break;
            }
            const end = Math.min(current + available, n);
            const part = message.substring(current, end);
            temp.push(part + partSuffix);
            current = end;
        }

        if (possible && current === n) {
            return temp;
        }
    }

    return [];
};