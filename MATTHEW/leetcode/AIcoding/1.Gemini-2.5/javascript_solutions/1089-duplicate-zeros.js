var duplicateZeros = function(arr) {
    const n = arr.length;
    let zeros = 0;
    let last = n - 1; // Pointer to the last element of the new array (initially same as original)

    // First pass: Determine the effective end of the original array that contributes
    // to the final array and count how many zeros will be fully duplicated.
    // 'i' iterates through the original array.
    // 'last - zeros' represents the effective length of the original array that can be processed.
    for (let i = 0; i <= last - zeros; i++) {
        if (arr[i] === 0) {
            // If this zero is the last element that fits into the new array,
            // it can only be copied once, not duplicated.
            if (i === last - zeros) {
                last--; // Adjust 'last' to represent this zero taking only one spot.
                break; // Stop, this zero is the last one to consider.
            }
            zeros++; // This zero will be fully duplicated, increasing the shift.
        }
    }

    // Now, 'last - zeros' gives the index of the last element in the original array
    // that needs to be read for the second pass.
    // 'last' points to the last index of the original array that will be filled.
    // 'zeros' is the total number of extra zeros that will be inserted.

    let readPtr = last - zeros; // Pointer for reading from the original array (from end)
    let writePtr = n - 1;       // Pointer for writing to the modified array (from end)

    // Second pass: Copy elements from right to left
    while (readPtr >= 0) {
        if (arr[readPtr] === 0) {
            // Duplicate the zero
            arr[writePtr] = 0;
            writePtr--;
            // Check bounds for the second zero copy
            if (writePtr >= 0) {
                arr[writePtr] = 0;
            }
            writePtr--;
        } else {
            // Copy non-zero element
            arr[writePtr] = arr[readPtr];
            writePtr--;
        }
        readPtr--;
    }
};