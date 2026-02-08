var minOperations = function(volunteers, target) {
    let left = 0;
    let currentSum = 0;
    let minLength = Infinity;
    const n = volunteers.length;

    for (let right = 0; right < n; right++) {
        currentSum += volunteers[right];

        while (currentSum >= target) {
            if (currentSum === target) {
                minLength = Math.min(minLength, right - left + 1);
            }
            currentSum -= volunteers[left];
            left++;
        }
    }

    return minLength === Infinity ? -1 : minLength;
};