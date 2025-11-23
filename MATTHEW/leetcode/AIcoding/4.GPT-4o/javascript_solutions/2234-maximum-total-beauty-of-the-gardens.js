var maximumBeauty = function(flowers, newFlowers, target) {
    flowers.sort((a, b) => a - b);
    let n = flowers.length;
    let left = 0, right = 0, total = 0, result = 0;

    while (right < n) {
        total += flowers[right];
        while (total + newFlowers < (right + 1) * target) {
            total -= flowers[left];
            left++;
        }
        result = Math.max(result, right - left + 1);
        right++;
    }

    return result;
};