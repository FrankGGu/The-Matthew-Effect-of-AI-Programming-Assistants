var minIncrementForUnique = function(nums) {
    if (nums.length <= 1) {
        return 0;
    }

    // The maximum possible value an element can become is max(nums) + nums.length - 1.
    // Given constraints: nums[i] <= 10^5, nums.length <= 10^5.
    // So, max possible value is around 10^5 + 10^5 - 1 = 199999.
    // We need a frequency array to cover values up to this maximum.
    // An array of size 200001 will cover indices from 0 to 200000.
    const freq = new Array(200001).fill(0);

    for (const num of nums) {
        freq[num]++;
    }

    let increments = 0;
    let taken = []; // Stack to store original values of duplicates that need to be moved

    // Iterate through all possible values up to the maximum possible unique value
    for (let i = 0; i <= 200000; i++) {
        if (freq[i] >= 2) {
            // If there are duplicates at index 'i', mark them as 'taken'
            // (freq[i] - 1) duplicates need to be moved
            for (let k = 0; k < freq[i] - 1; k++) {
                taken.push(i);
            }
        } else if (freq[i] === 0 && taken.length > 0) {
            // If the current slot 'i' is empty and we have 'taken' numbers
            // that need a spot, place one here.
            // Pop the largest original value from 'taken' (stack behavior)
            // and calculate the increments needed.
            const originalValue = taken.pop();
            increments += (i - originalValue);
        }
    }

    return increments;
};