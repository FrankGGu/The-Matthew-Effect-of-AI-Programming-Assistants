var splitMessage = function(message, limit) {
    const n = message.length;
    let k = 1;
    while (true) {
        let count = 0;
        let digits = String(k).length;
        for (let i = 1; i <= k; i++) {
            count += String(i).length;
        }

        let available = n;
        let possibleLength = limit - (digits + 3 + String(k).length);
        if (possibleLength <= 0) {
            return [];
        }

        let totalPossible = possibleLength * k;

        if (totalPossible >= n) {
            break;
        }
        k++;
    }

    const result = [];
    let digits = String(k).length;
    let possibleLength = limit - (digits + 3 + String(k).length);
    let start = 0;
    for (let i = 1; i <= k; i++) {
        let end = Math.min(start + possibleLength, n);
        result.push(message.substring(start, end) + "<" + i + "/" + k + ">");
        start = end;
    }

    return result;
};