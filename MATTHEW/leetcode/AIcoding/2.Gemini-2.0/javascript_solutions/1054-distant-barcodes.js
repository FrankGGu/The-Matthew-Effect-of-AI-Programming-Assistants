var rearrangeBarcodes = function(barcodes) {
    const counts = {};
    for (const barcode of barcodes) {
        counts[barcode] = (counts[barcode] || 0) + 1;
    }

    const sortedBarcodes = Object.entries(counts).sort(([, countA], [, countB]) => countB - countA);

    const result = new Array(barcodes.length);
    let index = 0;

    for (const [barcode, count] of sortedBarcodes) {
        for (let i = 0; i < count; i++) {
            result[index] = parseInt(barcode);
            index += 2;
            if (index >= barcodes.length) {
                index = 1;
            }
        }
    }

    return result;
};