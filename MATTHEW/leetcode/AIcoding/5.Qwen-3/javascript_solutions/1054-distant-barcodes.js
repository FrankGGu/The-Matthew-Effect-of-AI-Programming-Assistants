function rearrangeBarcodes(barcodes) {
    if (barcodes.length <= 1) return barcodes;

    const count = {};
    for (const code of barcodes) {
        count[code] = (count[code] || 0) + 1;
    }

    const sorted = Object.keys(count).sort((a, b) => count[b] - count[a]);

    const result = [];
    let index = 0;

    while (index < barcodes.length) {
        for (const code of sorted) {
            if (count[code] === 0) continue;
            result[index] = code;
            index++;
            count[code]--;
        }
    }

    return result;
}