#include <stdlib.h> // For malloc, qsort

typedef struct {
    int val;
    int count;
} BarcodeFreq;

int compareBarcodeFreq(const void *a, const void *b) {
    BarcodeFreq *freqA = (BarcodeFreq *)a;
    BarcodeFreq *freqB = (BarcodeFreq *)b;
    // Sort in descending order of count
    return freqB->count - freqA->count;
}

int* rearrangeBarcodes(int* barcodes, int barcodesSize, int* returnSize) {
    // Problem constraints state barcodesSize >= 1, so no need to handle barcodesSize == 0.
    // For barcodesSize == 1, the array is already valid.
    if (barcodesSize == 1) {
        *returnSize = 1;
        int* result = (int*)malloc(sizeof(int));
        result[0] = barcodes[0];
        return result;
    }

    // Max barcode value is 10000. Use a frequency array.
    // Initialize all frequencies to 0.
    int freq[10001] = {0}; 
    for (int i = 0; i < barcodesSize; i++) {
        freq[barcodes[i]]++;
    }

    // Populate a list of BarcodeFreq structs for non-zero frequencies
    // Max distinct barcodes is barcodesSize, but can be up to 10000 if all values are unique
    // and barcodesSize is large. Using 10001 as max possible distinct values.
    BarcodeFreq* freqList = (BarcodeFreq*)malloc(sizeof(BarcodeFreq) * 10001);
    int distinctBarcodes = 0;
    for (int i = 1; i <= 10000; i++) {
        if (freq[i] > 0) {
            freqList[distinctBarcodes].val = i;
            freqList[distinctBarcodes].count = freq[i];
            distinctBarcodes++;
        }
    }

    // Sort the list by frequency in descending order
    qsort(freqList, distinctBarcodes, sizeof(BarcodeFreq), compareBarcodeFreq);

    // Create the result array
    int* result = (int*)malloc(sizeof(int) * barcodesSize);
    *returnSize = barcodesSize;

    int current_idx = 0;
    for (int i = 0; i < distinctBarcodes; i++) {
        int val = freqList[i].val;
        int count = freqList[i].count;

        for (int j = 0; j < count; j++) {
            result[current_idx] = val;
            current_idx += 2;
            // If current_idx goes out of bounds (filled all even positions),
            // reset it to 1 to start filling odd positions.
            if (current_idx >= barcodesSize) {
                current_idx = 1; 
            }
        }
    }

    free(freqList); // Free the temporary frequency list

    return result;
}