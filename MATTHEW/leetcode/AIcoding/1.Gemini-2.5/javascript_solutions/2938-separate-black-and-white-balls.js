var minimumSteps = function(s) {
    let cost = 0;
    let leftPointer = 0; // This pointer tracks the next available position for a '1'

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            // If we find a '1', it needs to move to the position indicated by leftPointer.
            // The number of steps required is the difference between its current index 'i'
            // and its target index 'leftPointer'. This difference represents the number
            // of '0's it has to pass.
            cost += (i - leftPointer);
            // After moving this '1', the next '1' will occupy the next position.
            leftPointer++;
        }
    }

    return cost;
};