function beautifulBouquet(flowers, limit) {
    let freq = new Map();
    let left = 0;
    let maxLength = 0;

    for (let right = 0; right < flowers.length; right++) {
        freq.set(flowers[right], (freq.get(flowers[right]) || 0) + 1);

        while (freq.size > limit) {
            freq.set(flowers[left], freq.get(flowers[left]) - 1);
            if (freq.get(flowers[left]) === 0) {
                freq.delete(flowers[left]);
            }
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
}