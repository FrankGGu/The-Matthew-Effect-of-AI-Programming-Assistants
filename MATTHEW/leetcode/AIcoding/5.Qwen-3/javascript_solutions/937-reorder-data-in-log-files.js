function reorderLogFiles(logs) {
    return logs.sort((a, b) => {
        const isDigitA = isNaN(a.split(' ')[1]);
        const isDigitB = isNaN(b.split(' ')[1]);

        if (isDigitA && isDigitB) {
            return 0;
        } else if (isDigitA) {
            return 1;
        } else if (isDigitB) {
            return -1;
        } else {
            const logA = a.slice(a.indexOf(' ') + 1);
            const logB = b.slice(b.indexOf(' ') + 1);
            return logA.localeCompare(logB);
        }
    });
}