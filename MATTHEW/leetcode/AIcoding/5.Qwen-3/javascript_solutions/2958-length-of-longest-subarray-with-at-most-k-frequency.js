function longestSubarray(arr, k) {
    const freq = {};
    let left = 0;
    let maxLength = 0;

    for (let right = 0; right < arr.length; right++) {
        const num = arr[right];
        freq[num] = (freq[num] || 0) + 1;

        while (freq[num] > k) {
            freq[arr[left]]--;
            if (freq[arr[left]] === 0) {
                delete freq[arr[left]];
            }
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
}