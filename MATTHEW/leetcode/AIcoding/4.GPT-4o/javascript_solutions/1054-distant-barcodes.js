var rearrangeBarcodes = function(barcodes) {
    let count = new Map();
    for (let code of barcodes) {
        count.set(code, (count.get(code) || 0) + 1);
    }

    let sorted = [...count.entries()].sort((a, b) => b[1] - a[1]);
    let result = new Array(barcodes.length);

    let index = 0;
    for (let [code, freq] of sorted) {
        for (let i = 0; i < freq; i++) {
            result[index] = code;
            index += 2;
            if (index >= result.length) {
                index = 1;
            }
        }
    }

    return result;
};