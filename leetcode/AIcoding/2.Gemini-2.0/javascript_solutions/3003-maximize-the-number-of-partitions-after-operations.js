var maxPartitionsAfterOperations = function(nums) {
    const n = nums.length;
    let mask = new Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        let num = nums[i];
        let tempMask = 0;
        while (num > 0) {
            tempMask |= (1 << (num % 2));
            num = Math.floor(num / 2);
        }
        mask[i] = tempMask;
    }

    let orSum = 0;
    for (let i = 0; i < n; i++) {
        orSum |= mask[i];
    }

    let oneCount = 0;
    while (orSum > 0) {
        oneCount += (orSum & 1);
        orSum >>= 1;
    }

    if (oneCount <= 2) {
        return 1;
    }

    let partitions = 1;
    let currentOr = 0;
    for (let i = 0; i < n; i++) {
        currentOr |= mask[i];
        if (currentOr === orSum) {
            if (i < n - 1) {
                partitions++;
                currentOr = 0;
            }
        }
    }

    return partitions;
};