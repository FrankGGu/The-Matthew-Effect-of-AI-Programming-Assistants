var rearrangeBarcodes = function(barcodes) {
    const freqMap = new Map();
    for (const barcode of barcodes) {
        freqMap.set(barcode, (freqMap.get(barcode) || 0) + 1);
    }

    const sortedFreqs = Array.from(freqMap.entries()).sort((a, b) => b[1] - a[1]);

    const result = new Array(barcodes.length);
    let idx = 0;

    for (const [barcode, freq] of sortedFreqs) {
        for (let i = 0; i < freq; i++) {
            if (idx >= barcodes.length) {
                idx = 1; // Start placing at odd indices if even indices are exhausted
            }
            result[idx] = barcode;
            idx += 2;
        }
    }

    return result;
};